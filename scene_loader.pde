void loadScene(String name) {
  scene = loadStrings("scenes/"+name+".txt");
  //println(scene[0] + " " + (int)scene[0].charAt(0));
  if (scene[0].length()>0 && scene[0].charAt(0) > 255)
    scene[0] = scene[0].substring(1);
  next();
}

void next() {
  frameCount = 1;
  done = false;
  String step = scene[0];
  scene = subset(scene, 1);
  choices = null;
  choice = -1;


  String[] tokens = splitTokens(step.toLowerCase(), ",: ");
  if (tokens.length == 0) {
    next();
  } else if (step.startsWith("-")) {
    next();
  } else if (tokens[0].equals("scene")) {
    loadScene(tokens[1]);
  } else if (tokens[0].equals("character")) {
    character = loadImage("characters/" + tokens[1] + ".png");
    next();
  } else if (tokens[0].equals("background")) {
    background = loadImage("backgrounds/" + tokens[1] + ".png");
    next();
  } else if (tokens[0].equals("choice")) {
    choices = step.split(":")[1].trim().split(", ");
    choice = 0;
  } else if (tokens[0].equals("set")) {
    stats.put(tokens[1], int(tokens[2]));
    next();
  } else if (tokens[0].equals("add")) {
    int current = (stats.get(tokens[1])!=null) ? stats.get(tokens[1]) : 0;
    stats.put(tokens[1], int(tokens[2])+current);
    next();
  } else if (tokens[0].equals("sub")) {
    int current = (stats.get(tokens[1])!=null) ? stats.get(tokens[1]) : 0;
    stats.put(tokens[1], current-int(tokens[2]));
    next();
  } else if (tokens[0].equals("compare")) {
    int first, second;

    if (int(tokens[1])==0 && tokens[1].charAt(0) != '0') {
      first = (stats.get(tokens[1])!=null) ? stats.get(tokens[1]) : 0;
      
    } else {
      first = int(tokens[1]);
    }
    if (int(tokens[2])==0 && tokens[2].charAt(0) != '0') {
      second = (stats.get(tokens[2])!=null) ? stats.get(tokens[2]) : 0;
      
    } else {
      second = int(tokens[2]);
    }


    if (first > second)
      loadScene(tokens[3]);
    else
      loadScene(tokens[4]);
  } else {
    loadText(step);
  }


  //if (step.toLowerCase().startsWith("scene")) {
  //  loadScene(step.split(" ")[1]);
  //} else if (step.toLowerCase().startsWith("character")) {
  //  character = loadImage("characters/" + step.split(" ")[1] + ".png");
  //  next();
  //} else if (step.toLowerCase().startsWith("background")) {
  //  background = loadImage("backgrounds/" + step.split(" ")[1] + ".png");
  //  next();
  //} else if (step.toLowerCase().startsWith("choice")) {
  //  choices = step.split(":")[1].trim().split(", ");
  //  choice = 0;
  //} else if (step.toLowerCase().startsWith("set")) {
  //  String[] kv = step.toLowerCase().split(":")[1].split(" ");
  //  stats.put(kv[0].trim(), int(kv[1].trim()));
  //  next();
  //} else {
  //  loadText(step);
  //}
}