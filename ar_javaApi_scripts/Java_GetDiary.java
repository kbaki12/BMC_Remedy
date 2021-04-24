//Khal Baki     05/08/2012      Java_GetDiary.java 
//Note: Dumps Cost Centers records to a file.
//Use: 
//
//
//Changes:
//
//
//
////////////////////////////////////////////////////////////////

import com.bmc.arsys.api.*;
import java.util.*;
import java.io.*;

public class Java_GetDiary {
   public static void main(String[] args) {

        ARServerUser	arsServer = new ARServerUser();

        String arForm	 = args[0];
        String entryId   = args[1];
        String diaryName = args[2];
        String arUser	 = "System";


        try {

            Process arServer = Runtime.getRuntime().exec("/usr/bin/hostname");
            BufferedReader server = new BufferedReader(new
                 InputStreamReader(arServer.getInputStream()));
            // read the output from the command
            String Server = server.readLine();

            Process arKey = Runtime.getRuntime().exec("/usr/bin/cat /usr/local/ar/ref/pwd_enc_key.ref");
            BufferedReader key = new BufferedReader(new
                 InputStreamReader(arKey.getInputStream()));
            // read the output from the command
            String Key = key.readLine();

            String parm = "/usr/local/ar/scripts/get_pwd p " + Key + " " + Server + " " + arUser;

            Process arPwd = Runtime.getRuntime().exec(parm);
            BufferedReader pwd = new BufferedReader(new
                 InputStreamReader(arPwd.getInputStream()));
            // read the output from the command
            String Pwd = pwd.readLine();

            //System.out.println("\nServer: " + Server + "\tKey: " + Key + "\tUser: " + arUser + "\tPWD: " + Pwd);

            //Set the server info.
            arsServer.setServer(Server);
            arsServer.setUser(arUser);
            arsServer.setPassword(Pwd);

            //System.out.println("Connected to AR Server " + arsServer.getServer());

            arsServer.login();
            
            HashMap<String, Integer> MyFid = new HashMap<String, Integer>();
            
            //Get fields information, such as id, name, type ...etc.
            List<Field> fieldIds = arsServer.getListFieldObjects(arForm, 0);
            
            //Build a hash with key is field name, value is field id.
            //That way we can use field name insted of field id.
            for( int i = 0; i < fieldIds.size(); i++){
            	MyFid.put(fieldIds.get(i).getName(), fieldIds.get(i).getFieldID());
            }

            //Debug: shows field id from field name key
            //System.out.println("key: " + MyFid.get("Chargeable")); //Outputs field id
            
            String qualStr = "( \'Record Id\' = " + entryId + " )";
            //String qualStr = "( \'EntryID\' != null)";
            //String qualStr = "( \'EntryID\' != null)";
            QualifierInfo qual = arsServer.parseQualification(qualStr, fieldIds, null, Constants.AR_QUALCONTEXT_DEFAULT);

            //Use the hash key above to get list of needed fields.
            int[]  Fields  = {(Integer) MyFid.get(diaryName)};
            
            //Getting the list of entries with it's values.
            List<Entry> entryList = arsServer.getListEntryObjects(arForm, qual, 0, 0, null, Fields, false, null);
          
            //Output fields values.
            for( int i = 0; i < entryList.size(); i++ ){
                System.out.println (entryList.get(i).values());
               //System.out.println ("Got: " + i + entryList.get(i).get(MyFid.get(diaryName)) + "\n");
               //System.out.println ("Got Value:" + arsServer.decodeDiary(diaryName));
            }
            
            //Debug: Outputs total entries retrieved.
            //System.out.println ("Total Entries: " + entryList.size());
            
            //Logout AR server.
            arsServer.logout();
        }    
        catch (ARException e) {
            	e.printStackTrace();
            	arsServer.logout();
        }
        catch (IOException e) {
            System.out.println("exception happened - here's what I know: ");
            e.printStackTrace();
            System.exit(-1);
        }
   }          
	
   public void ARExceptionHandler(ARException e, String errMessage){
            System.out.println(errMessage);
            //printStatusList(arsServer.getLastStatus());
            System.out.print("Stack Trace:");
            e.printStackTrace();
   }

   public void printStatusList(List<StatusInfo> statusList) {
            if (statusList == null || statusList.size()==0) {
                System.out.println("Status List is empty.");
                return;
            }
            System.out.print("Message type: ");
            switch(statusList.get(0).getMessageType())
            {
                case Constants.AR_RETURN_OK:
                    System.out.println("Note");
                    break;
                case Constants.AR_RETURN_WARNING:
                    System.out.println("Warning");
                    break;
                case Constants.AR_RETURN_ERROR:
                    System.out.println("Error");
                    break;
                case Constants.AR_RETURN_FATAL:
                    System.out.println("Fatal Error");
                    break;
                default:
                    System.out.println("Unknown (" +
                        statusList.get(0).getMessageType() + ")");
                    break;
            }
            System.out.println("Status List:");
            for (int i=0; i < statusList.size(); i++) {
                System.out.println(statusList.get(i).getMessageText());
                System.out.println(statusList.get(i).getAppendedText());
            }
   }
}

