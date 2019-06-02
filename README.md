# TGFlingActionButton
Fling action button UIComponent in swift for iOS.

Do you want to have the 'Swipe to Proceed/Swipe to Agree/Swipe to Pay' buttons in your iOS apps, i.e. UIButton with the Fling/PanGesture to trigger the IBAction in your controller to perform the task.

Well..! Here is an easy to integrate class **"TGFlingActionButton"** that extends UIButton class which will convert your button on storyboard to fling action button. 

###### Follow the below steps to get your UIButton converted to fling action button:

1. Download the file **TGFlingActionButton.swift** and add it to your xcode project.
2. Go to story board screen, where you want to have the fling action button.
3. Drag the Button component from the object library to your story board screen.
4. Select the Button and go to identity inspector, here set the custom class for the button as **TGFlingActionButton**.
5. Now go to the attributes inspector of the button, here we can customize the fling action button by setting values for the below attributes.
      `InitialStateColor` - This attribute will set the colour indicating initial state before user swipe.
      `FinalStateColor`   - This attribute will set the colour to indicate the completion of user swipe action.
      `ImageFlingLayer`   - This attribute will set the image on the button. viz. right arrow for indicating the swipe direction.
      
