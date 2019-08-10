//String text = "Aidan looks like the quiet nerd at the back of the class who some guy would have a crush on after bumping into him in the hall carrying his study books, and he'd be super shy up until the end of the date night where he'd take his date out to the ally, bend him over, and show him the power of a Nat 20 to enlargement";
//String text = "What the frick did you just fricking say about me you little barf? I'll have you kno What the frick did you just fricking say about me you little barf? I'll have you kno What the frick did you just fricking say about me you little barf? I'll have you kno What the frick did you just fricking say about me you little barf? I'll have you kno What the frick did you just fricking say about me you little barf? I'll have you kno";
//String text = "Here\'s the thing. You said a \"jackdaw is a crow.\" Is it in the same family? Yes. No one's arguing that. As someone who is a scientist who studies crows, I am telling you, specifically, in science, no one calls jackdaws crows. If you want to be \"specific\" like you said, then you shouldn't either. They're not the same thing.If you're saying \"crow family\" you\'re referring to the taxonomic grouping of Corvidae, which includes things from nutcrackers to blue jays to ravens. So your reasoning for calling a jackdaw a crow is because random people \"call the black ones crows?\" Let\'s get grackles and blackbirds in there, then, too. Also, calling someone a human or an ape? It's not one or the other, that's not how taxonomy works. They're both. A jackdaw is a jackdaw and a member of the crow family. But that's not what you said. You said a jackdaw is a crow, which is not true unless you're okay with calling all members of the crow family crows, which means you'd call blue jays, ravens, and other birds crows, too. Which you said you don't. It's okay to just admit you're wrong, you know?";
//String text = "oh no";


//text arrays
String[] lines;
float[] space;
int[] pos;

String[] scene;

PImage character;
PImage background;

boolean done = false;

String[] choices;
int choice = -1;

HashMap<String, Integer> stats;

void setup() {
  
  size(800, 800);
  //fullScreen();
  textSize(height/40);
  imageMode(CENTER);
  stats = new HashMap<String, Integer>();
  loadScene("start");
}

void draw() {

  background(255);

  if (background != null)
    image(background, width/2, height/2);

  if (character != null)
    image(character, width/2, 3*height/8);

  stroke(25);
  strokeWeight(2);
  fill(#F0AEE0, 200);
  rect(50, 400, width-100, height-450, 25);

  fill(25);


  //print text from 3 arrays
  if (lines != null && choice == -1) {
    int y = 440;
    for (int i = 0; i < lines.length; i++) {
      String[] words = lines[i].substring(0, constrain(frameCount-pos[i], 0, lines[i].length())).split(" ");
      int x = 75;
      for (int j = 0; j < words.length; j++) {
        text(words[j], x, y);
        x += textWidth(words[j]) + space[i];
      }
      x = 75;
      y += height/32;
      if (y > height-50) {
        i = lines.length;
      }
    }

    if (frameCount > pos[pos.length-1] + lines[lines.length-1].length())
      done = true;
  } else if (choice > -1) {
    int y = 440;
    for (int i = 0; i < choices.length; i++) {
      text(choices[i].split("=")[0], 75, y);
      if (choice == i) {
        noFill();
        rect(70, y-(height/40), width-140, height/34);
      }
      y += height/30;
    }
  }
  //slow down text a bit
  delay(10);
}

void keyPressed() {
  if (choice == -1) {
    if (done) {
      next();
    } else {
      frameCount = 10000;
      done = true;
    }
  } else {
    if (keyCode == UP)
      choice = constrain(choice-1, 0, choices.length-1);
    else  if (keyCode == DOWN)
      choice = constrain(choice+1, 0, choices.length-1);
    else
      loadScene(choices[choice].split("=")[1]);
  }
}

//parse a string into the the three arrays
void loadText(String text) {
  String[] words = text.split(" ");
  int x = 75;
  text = "";

  //split text into lines
  for (int i = 0; i<words.length; i++) {
    String word = words[i] + " ";
    if (x+textWidth(word)<width-75) {
      text += word;
      x += textWidth(word);
    } else {
      text+="\n" + word;
      x = 75 + (int)textWidth(word);
    }
  }

  //take each line and figure out how wide the spaces should be
  lines = text.split("\n");
  space = new float[lines.length];
  pos = new int[lines.length];
  for (int i = 0; i < lines.length; i++) {
    String[] lineWords = lines[i].split(" ");
    space[i] = ((width-150)- textWidth(join(lineWords, "")))/(lineWords.length-1);
    pos[i] = text.indexOf(lines[i], pos[max(0, i-1)]);
  }
  space[space.length-1] = textWidth(" ");
}