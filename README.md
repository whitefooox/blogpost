![alt text](./assets/images/post_logo.png)
# blogpost

Mobile application for blogging

## stack
* dart
* flutter
* bloc (state)
* get_it (dependency injection)
* local_auth (biometric entry)
* firebase/core/auth/firestore/storage/messaging (data layer and notifications)
* image_picker (upload image)
* uuid (for uniqueness in storage)

## architectures
* core (common components for the entire application)
* modules (main functional parts)
  + auth
  + entry
  + notification
  + post
  + user
 
## preview
![alt text](./preview/signin.png)
![alt text](./preview/signup.png)
![alt text](./preview/create_lock.png)
![alt text](./preview/biometry_auth.png)
![alt text](./preview/without_account.png)
![alt text](./preview/my_posts.png)
![alt text](./preview/all_posts.png)
![alt text](./preview/create_post.png)
![alt text](./preview/edit_post.png)
![alt text](./preview/settings.png)
![alt text](./preview/profile.png)
![alt text](./preview/notifications.png)
