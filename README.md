# Smart voice assistant

### Quick start

Used technologies:

AIs
1. Wake Word (WW): https://picovoice.ai/platform/porcupine/
2. Speech-to-text (STT): https://github.com/guillaumekln/faster-whisper
3. Classifier: https://spacy.io/
4. Text-to-speech (TTS): https://mycroft.ai/mimic-3/
5. OpenAI ChatGPT: https://chat.openai.com/

Device controller:
6. Zigbee2Mqtt https://www.zigbee2mqtt.io/

Communication protocol:
7. MQTT https://mqtt.org/

Device:
8. Philips Hue Smart plug

### Instalation

Three services are running in the docker. By executing `docker run ...` it will fetch those images from docker hub.
One service (glue code) is running as systemd service. Smart voice assistant is made up by all these 4 services.


1. Run Speech-to-text (SST) service in a docker. 

`docker run -dit --name whisper-ai -p 8006:8006 sigidagi/faster-whisper-arm64`

2. Run Text-to-speech (TTS) service in a docker

```
mkdir -p "${HOME}/.local/share/mycroft/mimic3"
chmod a+rwx "${HOME}/.local/share/mycroft/mimic3"
docker run -dit -p 59125:59125 -v "${HOME}/.local/share/mycroft/mimic3:/home/mimic3/.local/share/mycroft/mimic3" 'mycroftai/mimic3
```

3. Run Classifier service in a docker 

`docker run -dit --name classifier-ai -p 7000:7000 sigidagi/classifier-arm64`

4. WakeUp Word service and 'glue code' for managing all ather services. 

```
git clone https://github.com/sigidagi/smartvoice
cd smartvoice
```

There is settings file `nobvoice.toml` where some credentials need to be added:
- https://console.picovoice.ai/  - accessKey for WakeUp Word detection algorithm
- Mqtt username and password.  
- optional - https://platform.openai.com/ - openAI API token


5. Run `./install.sh`

It will create `${HOME}/bin/nobvoice` directory and will start systemd service - systemd will know from which directory run binary. Service will reside in 
`${HOME}/.config/systemd/user` directory.
