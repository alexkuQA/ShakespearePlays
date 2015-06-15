To get the app up and running on a MarkLogic install:

1. Clone the repo to a machine running the MarkLogic Server.
2. Open the MarkLogic administration panel in browser, it’s running on port 8001 of the machine with MarkLogic install
3. Create a new DB, the step is optional, an existing DB can be used, e.g. Documents DB.
To create a new DB: choose the Databases item in the Configure tree on the left panel and switch to the Create tab on the right panel, enter a new DB name and click OK to create the database. Create a new forest and attach it to the created db.
4. Download the Shakespeare plays files in the xml format from the web http://metalab.unc.edu/bosak/xml/eg/shaks200.zip, unzip the file, load the files to the DB either using Information Studio Flows gui tools at http://IpOfMarkLogicMachine:8000/appservices or using http://IpOfMarkLogicMachine:8000/qconsole/ with querry like xdmp:document-load("/shaks200/as_you.xml", <options xmlns="xdmp:document-load"><uri>Shakespeare/as_you.xml</uri><repair>none</repair><permissions>{xdmp:default-permissions()}</permissions></options>); make sure all documents will be in the Shakespeare/ folder by uri as Shakespeare/as_you.xml in the example.
5. Create a Web Server: 
- Choose Groups > Default > App Servers on the left panel and choose Create HTTP web server tab on the right panel;
- Name the Server, enter the path to you app in the root folder field, the path to the folder containing the app files located on the machine with the MarkLogic install, enter the port number, choose the database that will be used by name from the database dropdown list, the database where the Shakespeare plays documents were loaded, scroll down to the authentication field and choose application-level from the dropdown, choose admin in the "default user" dropdown list;
- Click OK button to submit the form and launch the HTTP server.
5. Open the app in the browser accessing the machine ip address and the port that the server is running on, the app should be up and running.