//FaceOSC-Wekinator-4-24-18// edited by Dione

////////important set of default data for WekinatorParser--Processing/////
//Specify the number of Wekinator outputs 
final int number_wekinator_outputs = 1; 
//Current values in a [0.0 - 1.0] range
float current_values[];
//Class that parses the data received from Wekinator
WekinatorParser parser; 
//OSC port used by Wekinator
final int oscPort = 12000;
//Set to try to print the data
final boolean verbose = false;
//Set to false to disable easing effect in the sound/data
final boolean usingEasing = true;
//Amount of easing
final float easing = 0.05;
///////important set of default data for WekinatorParser--Processing/////


//custom code starts here
float a;
import ddf.minim.*;
Minim minim;
AudioPlayer clip;

void setup() {
  
  size(500, 500);
  minim = new Minim(this);
  clip = minim.loadFile("laugh.wav", 2048);
  clip.loop();
  
  //initialize the WekinatorParser
  parser = new WekinatorParser(number_wekinator_outputs,oscPort,usingEasing,easing,verbose);
  frameRate(60);
  smooth();
  noFill();
  }

void draw() {
  background(235);
  
  //Receives the values from Wekinator
  current_values = parser.calculateValues();
  
  //map values in wekinator to volume (see below, setGain)
  a = map(current_values[0], 0, 1, -1, -60);

  //test to see if gestures are happy
  evaluateExpression();
  
}

void evaluateExpression() {
  
  //if wekinator is outputting values:
  if(current_values.length !=0){
    
    //if output value of item [0]  (first item) is >0.001:
    if(current_values[0]>0.001){
      //we will recognize this as a happy expression, triggering the sound
        happyExpression();
    }    
     else {
    // if not, we will set the volume to zero/-1
    clip.setGain(-1);
  }
  } 
}


void happyExpression(){
  if ( clip.isPlaying() )
  {
    //set volume to a
    clip.setGain(a);
    
  }
}
 