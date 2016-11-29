PImage startImage, distImage;
PImage[] ungraImage = new PImage[6];
PImage[] pograImage = new PImage[6];

int[] ungraCanteen = new int[6];
int[] pograCanteen = new int[6];

int[][] ungraData = new int[6][120];
int[][] pograData = new int[6][120];

Table reader, canteenTrade;

PFont font1, font2;

String[] name = {"一餐","二餐","三餐","四餐","五餐","六餐","哈乐"};

enum state_t {
    start,
    dist,
    ungra,
    pogra
} ;

state_t state = state_t.start;

void setup () {
    size (1400, 700);
    
    startImage = loadImage ("start.jpg");
    startImage.resize (width, height);
    distImage = loadImage ("dist.jpg");
    distImage.resize (width, height);
    
    for (int i = 0; i < ungraImage.length; i ++) {
        ungraImage[i] = loadImage ("face" + i + ".jpg");
        ungraImage[i].resize (width, height);
    }
    for (int i = 0; i < pograImage.length; i ++) {
        pograImage[i] = loadImage ("facs" + i + ".jpg");
        pograImage[i].resize (width, height);
    }      
  
    font1 = createFont("方正小标宋_GBK",20);
    font2 = createFont("微软雅黑",20);
    
    canteenTrade = loadTable("canteen2.csv", "header");
    
    for (int i = 0; i < canteenTrade.getRowCount (); i ++) {
        TableRow row = canteenTrade.getRow (i);
        
        int switchCanteen = row.getInt("canteen");
        if (switchCanteen == 0) {
            continue;
        }
        ungraData[switchCanteen-1][ungraCanteen[switchCanteen-1]] = row.getInt ("amount");
        ungraCanteen[switchCanteen-1] ++; //<>//
    }
    
    canteenTrade = loadTable("canteen2.csv", "header");
    
    for (int i = 0; i < canteenTrade.getRowCount (); i ++) {
        TableRow row = canteenTrade.getRow (i);
        
        int switchCanteen = row.getInt("canteen");
        if (switchCanteen == 0) {
            continue;
        }
        pograData[switchCanteen-1][pograCanteen[switchCanteen-1]] = row.getInt ("amount");
        pograCanteen[switchCanteen-1] ++;
    }

}

void textWrite (String txt, float x, float y) {
    textFont(font2);
    textSize(24);
    textAlign(CENTER);
    fill(#43b68f);
    text (txt, x, y);
}

void draw () {
 //   println (mouseX, mouseY);
    switch (state) {
        case start: 
            background (startImage);
            if (mousePressed) {
                if (mouseY > 450 && mouseY < 600) {
                    if (mouseX > 600 && mouseX < 800) {
                        state = state_t.dist;
                    }
                }
            }
            
            break;
        case dist: 
            background (distImage);
            if (mousePressed) {
                if (mouseY > 560 && mouseY < 600) {
                    if (mouseX > 290 && mouseX < 600) {
                        state = state_t.ungra;
                    }
                    
                    if (mouseX > 740 && mouseX < 1050) {
                        state = state_t.pogra;
                    }
                }
                
                if (mouseX < 150 && mouseY < 50) {
                    state = state_t.start;
                }
            }
            
            break;
        case ungra: 
            int switchUngra = mouseX / (width/6);
            background (ungraImage[switchUngra]);
            
            strokeWeight (10);
            for (int i = 0; i < ungraData[switchUngra].length; i ++) {
                
                float heightY = map (ungraData[switchUngra][i], 0, 3000, 600, 200);
                int colorYellow = (int)map (heightY, 600, 300, 255, 0);
                stroke (255, 255, colorYellow);
                if (heightY != 600) 
                point (100 + i*(width/110), heightY);
                
            }
            if (mousePressed) {
                if (mouseX < 150 && mouseY < 50) {
                    state = state_t.dist;
                }
            }            
            
            break;
        case pogra: 
            int switchPogra = mouseX / (width/6);
            background (pograImage[switchPogra]);
            
            strokeWeight (10);
            for (int i = 0; i < pograData[switchPogra].length; i ++) {
                
                float heightY = map (pograData[switchPogra][i], 0, 1200, 600, 200);
                int colorYellow = (int)map (heightY, 600, 300, 255, 0);
                stroke (255, 255, colorYellow);
                if (heightY != 600) 
                point (100 + i*(width/110), heightY);
                
            }
            
            if (mousePressed) {
                if (mouseX < 150 && mouseY < 50) {
                    state = state_t.dist;
                }
            }   
                
            break; 
    }
}