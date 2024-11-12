PImage imgBig;    //印出圖片
PImage [][]imgSmall;    //代表會有幾乘幾的拼圖框架出現
PVector [][]coord;    //拼圖的座標，用來移動拼圖
void setup(){
  size(1200,600);
  readFile("1.jpg");
}
void readFile(String filename){
  imgBig = loadImage(filename);
  imgSmall = new PImage[6][8];    //因為圖片太大，所以陣列內數字增加
  coord = new PVector[6][8];
  for(int i=0;i<6;i++){
    for(int j=0;j<8;j++){
      imgSmall[i][j] =imgBig.get(200*j,200*i,200,200);    //前者兩個數字圖片視角遠近，數字越大視角越遠，前後數字要一樣
      coord[i][j]=new PVector(85*j,85*i);    //這兩個數字代表拼圖間的間隔，數字越大間距越大，數字越小間距越小
    }
  }
  for(int k=0;k<10;k++){    //此迴圈能隨機改變拼圖位置，而k所寫的數字代表拼圖交換幾次
    int i1=int(random(6)),i2=int(random(6));
    int j1=int(random(8)),j2=int(random(8));
    PVector temp = coord[i1][j1];//new PVector(coord[i1][j1].x,coord[i1][j1].y);
    coord[i1][j1]=coord[i2][j2];
    coord[i2][j2]=temp;
  }  
}
void draw(){
  background(#F1FFB2);    //背景顏色改黑，否則要是背景為白的情況下，移動會出現殘影
  image(imgBig,700,90,480,330);  //前兩個數字是座標，後面則是圖片大小
  fill(#25E539);
  rect(700,430,450,120);  //告示牌
  PFont font = createFont("標楷體",40);  //文字字體，大小
  textFont(font);
  fill(#2C1C76);  
  text("拼圖遊戲",850,60);
  PFont font1 = createFont("宋體",30);  //文字字體，大小
  textFont(font1);
  fill(#2C1C76);  
  text("上一張圖請按1",800,520);
  text("下一張圖請按2",800,480);
  for(int i=0;i<6;i++){
    for(int j=0;j<8;j++){
      image(imgSmall[i][j],coord[i][j].x,coord[i][j].y,80,80);    //此數字代表拼圖框框的大小，寫80的緣故是為了容易分辨    
      noFill();    //保證每個位置都有圖片
      //rect(200*j,200*i,200,200);
    }
  }
}
int selectedI=-1,selectedJ=-1;
void mousePressed(){    //點擊
  int selectI=-1,selectJ=-1;
  for(int i=0;i<6;i++){
    for(int j=0;j<8;j++){
      if(coord[i][j].x<mouseX && mouseX<coord[i][j].x+80 && coord[i][j].y<mouseY && mouseY<coord[i][j].y+80){    //不太理解，只知道x、x+80是指拼圖在該圖片的位置
      selectI =i; selectJ=j;
      }
    }
  }
  if(selectI!=-1){
    selectedI=selectI;
    selectedJ=selectJ;
  }
}
void mouseDragged(){    //拖曳
  if(selectedI!=-1){
    coord[selectedI][selectedJ].add(new PVector(mouseX-pmouseX,mouseY-pmouseY));
  }
}
void mouseReleased(){
  PVector now = coord[selectedI][selectedJ];
  int II=0, JJ=0;
  float min=9999999;
  for(int i=0;i<=6;i++){
    for(int j=0;j<=8;j++){
      float len = dist(now.x, now.y, 85.0*j, 85.0*i);  //數字代表拼圖間的吸附距離
      if(len<min){
        min = len;
        II = i;
        JJ = j;
      }
    }
  }
  now.x = 85.0*JJ;
  now.y = 85.0*II;
  selectedI=-1;
  selectedJ=-1;
}
void keyPressed(){
  if(key=='1') readFile("1.jpg");
  if(key=='2') readFile("2.jpg");
  if(key=='3') readFile("3.jpg");
}
