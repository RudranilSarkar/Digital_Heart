Project Digital Heart (User Manual)



Software required:

•	MATLAB R2018a trial:
o	Download Link- https://in.mathworks.com/campaigns/products/trials.html  
•	WinRAR:
o	Download Link- https://www.win-rar.com/start.html?&L=0











MATLAB Installation Guide:
Step-1:
Go to The above mentioned link and create an account to download MATLAB executable file.
 


Step-2:
Leave the Log In with a MathWorks Account option selected (the default), and then click Next. During installation, you log in to your MathWorks Account, select the license you want to install, and follow the prompts in the installer.
 
Step-3:
To log in to your MathWorks Account, enter your email address and password, and click Next. 

Step-4:

Select a license from the list of licenses associated with your MathWorks Account and click Next.
If you want to install products on a license that is not associated with your MathWorks Account:
1.	Select the Enter an Activation Key for a license not listed option.
2.	Enter an Activation Key and click Next.
 
Step-5:
Specify the Installation Folder
 
Step-6:
Install the product
 





Guide to open our Project:
•	Extract the files using WinRAR and save the folder in a drive 
•	Start MATLAB
•	Go to Apps
•	Click on install app
•	Then go to the directory where you have extracted the ‘Digital_Heart/FinalSubmission’ folder and click on the file name DigitalHeart.mlappinstall
•	Then click on open and then click on install button
•	The DigitalHeart app will appear in the apps dropdown menu 
•	Set path to ‘Digital_Heart/FinalSubmission’ folder 
•	Click on the DigitalHeart app to run it 
•	Now the DigitalHeart graphical interface will open 
•	Click on the  “Get & process ECG data “ to get the desired ECG wave from the ‘FinalSubmission’ 
•	Now the ECG wave and its extracted features  along with the ECG signal prediction should appear and also the value (0 or 1) of ECG block in the hear risk prediction parameters panel should appear
•	Now go to the FinalSubmission and double click on the “9attributes_dataset.xml”  To open it and select a desired row to test the data. Now fill up the other parameters manually referring to the above mentioned file to the heart risk prediction parameter panel 
•	Click on “Check Risk Percentage” button to start and simulate the simulink model
•	Now click on the graphical user interface window and you should see the risk percentage and risk reduction suggestion . 
•	You can use the “Clear” buttons to clear all the fields and enter new data . 
•	Click on the “EXIT” button to close the Graphical User Interface.


NOTE : Do not try to enter new ECG data without clearing the data fields or else the app may  misbehave            









Files that will be stored inside the package :
•	DigitalHeart.mlappinstall
•	ANNmatrix.m
•	ANNsimulink.slx
•	ANNsimulink.slxc
•	9attributes_dataset.xlsx
•	ECGalgoMatrix.m
•	FinalProject.fig
•	FinalProject.m
•	50 ECG data files(ECG1,ECG2. . . ECG50)

