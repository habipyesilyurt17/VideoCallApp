# Vide Call
- The application uses the agora.io SDK to bring users together in a video call with a static channel name.
- The process is triggered through the project I created via Agora console.
- I created an agora-token-service using railway. (https://agora-token-service-production-d0fa.up.railway.app/)
- I am generating a token using this token service. I use this token to join the video call channel.
- I also designed the live chat screen and wrote the background via video call. However, the token requested to enable users to join the chat application did not accept the token I produced. Therefore, I could not create a user for the chat application with the username obtained when logging into the application.


# Development Tools's Versions
- Xcode 15.2
- iOS17.2

# Architecture
- MVVM

# Features
- Storyboard & Programmatic UI
- Used SPM for Dependency Manager
- URLSession for Networking


# 3rd Party Libraries
- [Agora](https://www.agora.io/en/)

# Screenshots
<div style="display:flex; justify-content:center;">
    <img src="https://github.com/habipyesilyurt17/VideoCallApp/assets/43083994/557e8825-fdbc-4e10-88b4-a9ba5417ccb0" width="350" height="600">
</div>
