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
    _joyx = nunchuck_joyx(); // ranges from approx 65 - 173
    _joyy = nunchuck_joyy(); // ranges from approx 65 - 173
    _zbut = nunchuck_zbutton();
    _cbut = nunchuck_cbutton();
}

void loop()
{
    nunchuck_get_data();

    joyx = nunchuck_joyx(); // ranges from approx 65 - 173
    joyy = nunchuck_joyy(); // ranges from approx 65 - 173
    zbut = nunchuck_zbutton(); // ranges from approx 65 - 173
    cbut = nunchuck_cbutton(); // ranges from approx 65 - 173
    
    if(_joyx!=joyx&&_joyy!=joyy) {
      _joyx = joyx;
      _joyy = joyy;
      String joyToTheJSON = "{\"joystick\":["+String((byte)joyx,DEC)+","+String((byte)joyy,DEC)+"]};";
      Serial.print(joyToTheJSON);
    }
    /*
    if(_zbut!=zbut) {
      _zbut = zbut;
      String output = "{\"z\":"+String((byte)zbut,DEC)+"};";
      Serial.print(output);
    }
    
    
    if(_cbut!=cbut) {
      _cbut = cbut;
      String output = "{\"c\":"+String((byte)cbut,DEC)+"};";
      Serial.print(output);
    }
    */
    delay(1);
}

