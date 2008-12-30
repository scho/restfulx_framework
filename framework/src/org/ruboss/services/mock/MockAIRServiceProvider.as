/*******************************************************************************
 * Copyright 2008, Ruboss Technology Corporation.
 * 
 * @author Dima Berastau
 * 
 * This software is dual-licensed under both the terms of the Ruboss Commercial
 * License v1 (RCL v1) as published by Ruboss Technology Corporation and under
 * the terms of the GNU General Public License v3 (GPL v3) as published by the
 * Free Software Foundation.
 *
 * Both the RCL v1 (rcl-1.0.txt) and the GPL v3 (gpl-3.0.txt) are included in
 * the source code. If you have purchased a commercial license then only the
 * RCL v1 applies; otherwise, only the GPL v3 applies. To learn more or to buy a
 * commercial license, please go to http://ruboss.com. 
 ******************************************************************************/
package org.ruboss.services.mock {
  import flash.data.SQLStatement;
  import flash.filesystem.File;
  import flash.utils.describeType;
  import flash.utils.getQualifiedClassName;
  
  import mx.rpc.IResponder;
  
  import org.ruboss.Ruboss;
  import org.ruboss.controllers.ServicesController;
  import org.ruboss.services.air.AIRServiceProvider;
  import org.ruboss.utils.RubossUtils;

  public class MockAIRServiceProvider extends AIRServiceProvider {

    public static const ID:int = ServicesController.generateId();
            
    public override function get id():int {
      return ID;
    }
    
    public function MockAIRServiceProvider() {
      var databaseName:String = Ruboss.airDatabaseName;
      var dbFile:File = File.userDirectory.resolvePath(databaseName + ".db");
      if (dbFile.exists) {
        dbFile.deleteFile();
      }
      
      super();
    }
    
    public function loadTestData(dataSets:Object):void {
      Ruboss.log.debug("loading test data for MockAIRServiceProvider");
        
      for (var dataSetName:String in dataSets) {        
        Ruboss.log.debug("loading test data for :" + dataSetName);
        for each (var instance:Object in 
          Ruboss.serializers.xml.unmarshall(dataSets[dataSetName])) {
          create(instance, null);    
        }
      }
    }
  }
}