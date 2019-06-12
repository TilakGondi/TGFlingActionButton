# TGFlingActionButton
Fling action button UIComponent in swift for iOS.

Do you want to have the 'Swipe to Proceed/Swipe to Agree/Swipe to Pay' buttons in your iOS apps, i.e. UIButton with the Fling/PanGesture to trigger the IBAction in your controller to perform the task.

Well..! Here is an easy to integrate storyboard friendly class **"TGFlingActionButton"** that extends UIButton class which will convert your button on storyboard to fling action button. 

###### Follow the below steps to convert the UIButton on storyboard to fling action button :

1. Download the file **TGFlingActionButton.swift** and add it to your xcode project.
2. Go to story board screen, where you want to have the fling action button.
3. Drag the Button component from the object library to your story board screen.
4. Select the Button and go to identity inspector, here set the custom class for the button as **TGFlingActionButton**.
5. Now go to the attributes inspector of the button, here we can customize the fling action button by setting values for the below attributes.\n
      * `InitialStateColor` - This attribute will set the colour of swipeable layer indicating initial state before user swipe.
      * `FinalStateColor`   - This attribute will set the colour of swipeable layer to indicate the completion of user swipe action.
      * `ImageOverlay`   - This attribute will set the image on the button. viz. right arrow for indicating the swipe direction.
      
6. Then open up the assistant editor  for the storyboard seen with the button and do the following.
     * Connect the @IBAction method with the action type as  `value changed`  and sender object class as `TGFlingActionButton` from storyboard to the view controller class. `This method will be triggered when the user completes the swipe action`.
                `@IBAction func flingActionCallback(_ sender: TGFlingActionButton)`
     * In the @IBAction function we will get the direction in which user has swiped the button, here we can trigger the appropriate process/api calls/payment methods based on the users swiped direction as per the requirements. 
     * Further if you woud like to further change the appearence of the button i.e. title, colour etc. you can have the IBOutlet for the button.
        
Yes...! thats it.

Feel free to customize the button as per your requirements. This was just an idea/ convinence class that I have created for quick integration of fling action button in iOS projects.

> I would appreciate your suggestions for further improvement of this UI component.

Happy coding !
      
