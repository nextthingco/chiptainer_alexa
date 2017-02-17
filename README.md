# CHIPtainer Example: Wifi Access Point

This is a Docker file for building a container that allows you to record a question and have Alexa answer back.

In order to get this project working, you will need to attach a button to CSID0, which connects this pin to 3.3v when it is pressed. You can also connect to LED's to CSID1 and CSID2 to see activity indication. Be sure to also connect a microphone and a speaker.

First, we need to complete the software setup process. Create a developer account with Amazon or log into your existing account:

```
https://developer.amazon.com
```

Once registered, click on **"Alexa"** on the top menu and then select **"Get Started"** under the **"Alexa Voice Service"** button.

From the **"Select product type"** pulldown menu, click on **"Device"**

Now enter a **"Device Type ID "**. For example, **"my_device"**. When done, select **"Next"**

Now select **"Security Profile"** from the menu on the left.

You should see a pulldown menu next to the words, **"Security Profile"**. Select the device you just created. For example, **"my_device"**.

Now you will see text fields labled **"Security Profile Description"**, **"Security Profile ID"**, and others. Click the **"edit"** button and fill out the profile ID and description with whatever you want.

Keep this page open as we will need to copy these values in a little bit.

It is now time to launch our Docker container! You can do this on a CHIP with Docker installed. First, log into Docker:

```
docker login ntc-registry.githost.io
```

Then download the latest Alexa Docker container.

```
docker pull ntc-registry.githost.io/nextthingco/chiptainer_alexa:master
```

Now run the container:

```
docker run --name alexa --privileged --net=host --cap-add SYS_RAWIO --device /dev/mem -v /sys:/sys -ti ntc-registry.githost.io/nextthingco/chiptainer_alexa:master
```

You will now be asked to enter your security information. Enter the values from the **"Security Profile"** webpage.

Once you enter this information, your Docker container will present you with two web addresses. For example:

```
Allowed Origins: http://10.0.1.1:5000
Allowed Return URL: http://10.0.1.1:5000/code
```

Back on the **"Security Profile"** page, select **"Web Settings."** Put the two web addresses into the form and then click next.

Your Docker container has created a webpage to complete the authentication process. For example:

```
http://10.0.1.1:5000
```

Visit this webpage on a computer that is connected to the same network as your device. Complete the instructions on the page.

If all went well, Alexa should now start on your Docker container. Press the button you rigged up earlier which should start recording. Releasing the button sends your question to Alexa, after which you should hear a response.

**NOTE:** If you see a message that says "*MemCached: MemCache: inet:127.0.0.1:11211: connect: [Errno 111] Connection refused.  Marking dead.*", you can ignore it.

If you wish to stop this container, you can press CTRL-C and then type **"exit"**. 
