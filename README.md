# csc-680-Final-Project

## Group Members
Vicente Pericone
<br>
Manjot Singh

## Project Proposal
This is an IOS App that will allow users to create a portfolio and upload projects that is visible to other users. In addiition to uploading projects, users will be able to post updates about their projects. 
<br>
## Initial Proposal
## Actions Users can take
* Upload Projects 
  * Details may include: Title of the project, Description, Photos, links
  * Users can post updates to their projects (creating a thread of posts under the project)
* Login and Register Accounts
  * Details may include: Username, Password, Name, Education, links, skills
* Search
  * Users can search for accounts, Projects, schools, skills
* Send messages to other users       

## Completed
* Login and Register Accounts
  * We used firebase authentication to autheticate users when they login in and create a user when they register
  * We used a Firestore database to store the user information to retrieve it later
* Uploading Posts
  * Users can create a post with a Title, Decription, and a Picture and stores it to firebase
* Displaying Posts
  * The posts users upload are displayed on home view where it pulls the data from firestore and displays individual views in a list for each post
* Viewing Profile
  *  Users can view their own profile from data from Firebase
