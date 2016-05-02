# MobappFinal

Homeless README:

It uses:

-	 Kinvey to Store data
-	 CollectionView
-	ImagePicker
-	Segues
-	TableView
-	Calling on Phone
-	Sharing


View Controller:
-	Type your username and password and signup the first time you are using
-	You can login after you are signed up
-	If you are already logged in, it will directly take you to the main View Controller

Main Display Controller:
-	 This is the main page of the app.
-	It initially shows All stories that people have added to the firebase.
-	You can scroll horizontally to see all the posts.
-	It has a “My stories” button on top right which queries for private items that only you have uploaded.
-	You can see Logout button which log you out and unwind the segue back to login controller page.
-	If you click on individual pictures, it will take you to the detail Controller page.
-	If you click on “Add Story” button on top right, it will take you to the add controller page where you can add posts.

Detail Controller Page:
-	It shows you the Story, name of person, location, image, of the Story you have clicked
-	You can also share it and call the owner.
-	You can post comments too.
-	Click on back to go back to Main Display Controller Page.
-	You can also edit your own stories in this page. Just change name, location, not stories though. Click on “Editing Done”. You are only allowed to do that to your own stories.

Add Controller Page:
-	Click on “Add pic” to choose pictures from gallery or “Take Photo” to capture from camera if you are on phone.
-	Type the description of your story in description textview.
-	Fill out the given textfields
-	Make sure all of the above steps are completed and then click on “Submit”
-	Go back to Main Display Controller page to see the items you have just added

Disclaimer:
-	You might not see all stories immediately because of the delay in querying. Wait for sometime or try clicking on “All Stories” or “My Stories” and wait again.
-	Use Phone number for signing up, otherwise it won’t call the uploader.
-	Make sure you have followed all the steps in add controller page before submitting















README Firewater

It uses:
-	Firebase to store data
-	CollectionView
-	DatePicker
-	ImagePicker
-	Segues
-	Sharing, Sharing to Facebook
-	Alert

Login Controller:
-	Type your username and password and signup the first time you are using
-	You can login after you are signed up
-	If you are already logged in, it will directly take you to the main View Controller

View Controller:
-	This is the main page of the app.
-	It initially shows public posts that people have added to the firebase.
-	You can scroll horizontally to see all the posts.
-	It has a “See Private items” button on top left which queries for private items that only you have uploaded. This button will toggle once you click it
-	You can see Logout button which log you out and unwind the segue back to login controller page.
-	If you click on individual pictures, it will take you to the detail Controller page.
-	If you click on “Add more” button on top right, it will take you to the add controller page where you can add posts.

Detail Controller Page:
-	It shows you the name, image, date of the item you have clicked
-	You can also share normally and also to Facebook.
-	Click on back to go back to View Controller Page

Add Controller Page:
-	Click on Choose Pic to choose pictures from gallery
-	Type your message in the given textfields.
-	Pick date using “Pick date” button
-	Click on “Make it Private” if you want to save it privately, or leave it as it is to save it publicly.
-	Make sure all of the above steps are completed and then click on upload
-	Go back to View Controller to see the items you have just added


Disclaimer:
-	View Controller might not immediately show all posts because of the time it takes for querying data. You might need to go to Add Controller page and come back.
-	Make sure You fill out all the fields in add controller page. 


















README for Maps app iOS

It uses:

-	Google Maps Api
-	Segue
How to Use:
-	Run application on the machine
-	It will ask for the location access on your phone, and will update location after getting permission.
-	Map will focus on the updated location
-	Type the name of restaurant you want to see in the top most textfield.
-	It will drop pins on the restaurants nearby of the type you want.
-	Click on the pins to see annotations.
-	Click on the annotations to segue to the detail page
-	Detail page consists of name, latitude, longitude, address and image retrieved from google maps API.

Disclaimer:
-	Application  might not function properly in simulator because of location settings. You might need to reboot simulator, set custom location to your area and run the app
-	Photo might not display in detail controller page if there is no photo in api callback




















