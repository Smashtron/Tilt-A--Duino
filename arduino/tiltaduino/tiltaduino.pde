/*
 * WiiChuckDemo -- 
 *
 * 2008 Tod E. Kurt, http://thingm.com/
 *
 */

#include <Wire.h>
#include "nunchuck_funcs.h"

int loop_cnt=0;

byte accx,accy,accz,joyx,joyy,zbut,cbut;
byte _accx,_accy,_accz,_joyx,_joyy,_zbut,_cbut;
int ledPin = 13;


void setup()
{
    Serial.begin(19200);
    nunchuck_setpowerpins();
    nunchuck_init(); // send the initilization handshake
    
    nunchuck_get_data();
    _accx = nunchuck_accelx();
    _accy = nunchuck_accely();
    _accz = nunchuck_accely();
    _joyx = nunchuck_joyx();
    _joyy = nunchuck_joyy();
    _zbut = nunchuck_zbutton();
    _cbut = nunchuck_cbutton();
}

void loop()
{
    nunchuck_get_data();

    accx = nunchuck_accelx();
    accy = nunchuck_accely();
    accz = nunchuck_accely();
    joyx = nunchuck_joyx(); // ranges from approx 65 - 173
    joyy = nunchuck_joyy(); // ranges from approx 65 - 173
    zbut = nunchuck_zbutton(); // ranges from approx 65 - 173
    cbut = nunchuck_cbutton(); // ranges from approx 65 - 173
    
    String update = "";
    boolean sendUpdate = false;
    
    if(_accx!=accx&&_accy!=accy&&_accz!=accz) {
      sendUpdate = true;
      _accx = accx;
      _accy = accy;
      _accz = accz;
      update += "{\"accelerometer\":["+String((byte)accx,DEC)+","+String((byte)accy,DEC)+","+String((byte)accz,DEC)+"]};";
    }
    if(_joyx!=joyx&&_joyy!=joyy) {
      sendUpdate = true;
      _joyx = joyx;
      _joyy = joyy;
      update += "{\"joystick\":["+String((byte)joyx,DEC)+","+String((byte)joyy,DEC)+"]};";
    }
    if(_zbut!=zbut) {
      sendUpdate = true;
      _zbut = zbut;
      update += "{\"z\":"+String((byte)zbut,DEC)+"};";
    }
    if(_cbut!=cbut) {
      sendUpdate = true;
      _cbut = cbut;
      update += "{\"c\":"+String((byte)cbut,DEC)+"};";
    }
    
    if(sendUpdate==true)  {
      Serial.print(update);
    }
    delay(1);
}

