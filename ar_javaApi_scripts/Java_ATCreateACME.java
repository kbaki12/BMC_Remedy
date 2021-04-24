import com.bmc.arsys.api.*;
import java.util.*;
import java.io.*;
import java.lang.*;

public class Java_ATCreateACME {

    public static void main(String[] args) {

        if (args.length != 2) {
           System.out.println ("Incorrect number of arguments passed!");
           System.out.println ("Usage: java Java_ATCreateACME Description Details");
           System.exit(0);
        }
       
        Entry entry       = new Entry(); 
        String arForm     = "Activity Tracker";
        String EntryID    = "";

        ARServerUser     arsServer = new ARServerUser(); 
        String arUser     = "System";
        String formName   = "Messages Notifications";
        String desc       = args[0];
        String details    = args[1];

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
            arsServer.setServer(Server);
            arsServer.setUser(arUser);
            arsServer.setPassword(Pwd);
        
            //System.out.println("Connected to AR Server " + arsServer.getServer());

            arsServer.login();

            String supparea = "IS - Applications";
            String submsa   = "Via Batch Email";

            entry.put(new Integer("536870939"),new Value("acme"));    //Login
            entry.put(new Integer("536870954"),new Value("TBD"));     //Category
            entry.put(new Integer("536870960"),new Value("TBD"));     //SubCategory
            entry.put(new Integer("536870912"),new Value("AC00252")); //ActCode
            entry.put(new Integer("536870929"),new Value("3"));       //Type
            entry.put(new Integer("14"),new Value("1"));              //Priority
            entry.put(new Integer("8"),new Value(desc));              //Description
            entry.put(new Integer("9"),new Value(details));           //Details
            entry.put(new Integer("536870926"),new Value(supparea));  //SuppArea
            entry.put(new Integer("7"), new Value("0"));              //Status
            entry.put(new Integer("2"),new Value("System"));          //Submitter
            entry.put(new Integer("536871203"),new Value("0"));       //WSDL
            entry.put(new Integer("536870940"),new Value(submsa));    //description

            EntryID = arsServer.createEntry(arForm, entry);
            System.out.println("EntryID="+EntryID);

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
