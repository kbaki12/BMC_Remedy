//Khal Baki     09/05/2012      Java_CreateTicket.java 
//Note: Update AR tickets in any given schema. 
//Use: java Java_UpdateTicket formName numFields 1 attId attName attPathe fildId value ... 
//     Read below for more details.
//
//Changes:
//
//
//
////////////////////////////////////////////////////////////////

import com.bmc.arsys.api.*;
import java.util.*;
import java.io.*;
import java.lang.*;

public class Java_UpdateTicket {

   public static void main(String[] args) {

      if (args.length <= 3) {
         System.out.println ("Incorrect number of arguments passed!");
         System.out.println ("\nUsage: java Java_CreateTicket formName numFields 1 attId attName attPathe fildId value ...");
         System.out.println ("Usage: java Java_CreateTicket formName numFields 0 fildId value ...");
         System.out.println ("1) numFields: Number of fields to pass.");
         System.out.println ("2) 1 : Means you are passing an attachment(Example one).");
         System.out.println ("3) 0 : Means you are not passing an attachment, only field ids and values.");
         System.out.println ("4) Note: if you are passing an attachment - Provide the attachment info first.");
         System.exit(0);
      }

      ARServerUser    arsServer = new ARServerUser();
      String mesg     = null;
      Entry entry     = new Entry();
      String entryId  = null;
      String arUser   = "System";
      String fidId    = null;
      String fidValue = null;
      String formName = args[0];
      String feildNum = args[1];
      String attFlag  = args[2];

      //String attName  = "attach.txt";

      // Cast the string attFlag to int.
      Integer attachFlag = new Integer(attFlag);

      // Cast the string feildNum to int.
      Integer nFields = new Integer(feildNum);
      String arrayFid[] = new String[nFields];
      String arrayFidValue[] = new String[nFields];

      int count = 3;

      if(attachFlag >= 1) {
         //System.out.println("Attach Flag: " + attFlag);
         count = count + 3;
      }

      do {
         arrayFid[nFields-1] = args[count];                    
         arrayFidValue[nFields-1] = args[count+1];  
         nFields--;
         count = count+2;         
         //System.out.println("NumFields: " + nFields + " counter: " + count + "\n");

       } while (nFields > 0);

       //*****UnComment below for debugging
       //for (int i = 0; i < arrayFid.length; i++) { 
       //   System.out.print("FieldId: " + arrayFid[i] + "~Value: " + arrayFidValue[i] + "\n");    
       //}

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

         for (int i = 0; i < arrayFid.length; i++) {
            //System.out.print("FieldId: " + arrayFid[i] + "~Value: " + arrayFidValue[i] + "\n");
            entry.put(new Integer(arrayFid[i]), new Value(arrayFidValue[i]));
            int recid = Integer.parseInt(arrayFid[i]); 
            if(recid == 1) { 
               entryId = arrayFidValue[i];
               System.out.println("Entry id Passed: " + entryId + "\n");
            } 
         }

         if(attachFlag >= 1) {
            String attId   = args[3];
            String attName = args[4];
            String attPath = args[5];
            AttachmentValue attach = new AttachmentValue(attName);
            String filePath = attPath + attName;
            attach.setValue(filePath);
            entry.put(new Integer(attId), new Value(attach));
         }

         //EntryID = arsServer.createEntry(formName, entry);
         arsServer.setEntry(formName, entryId, entry, null, 0);
         System.out.println("Modified EntryId: "+entryId);

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
}
