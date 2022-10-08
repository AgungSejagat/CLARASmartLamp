We created this application to add flexibility and accessbility for our IoT Project which it is a Multiple Feature Lamp powered by ESP32 and Neopixel.
The overview of our IoT Project can be viewed from this Instructables' link. ( https://www.instructables.com/Mulitiple-Feature-Smart-Lamp/ )
This application able to manipulate the color and the brightness of the lamp remotely. 
It works by sending the new desired RGB value from this application into Firebase database. After the values in Firebase successfully updated, the new values will notify the ESP32 inside the lamp and update the values inside into the new one.
When the values in ESP32 has been updated, the neopixel LED will adjust to the new values thus the color radiant differently.
