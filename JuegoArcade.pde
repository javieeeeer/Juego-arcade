float lineaA;
float lineaB;
float lineaC;

int bw = 100;
int cw = 400;

//-------------------------------------
//SERPIENTE
float[] x = new float[20];
float[] y = new float[20];
float segLength = 3;
//-------------------------------------
float distancia;
//-------------------------------------
//BOLITAS
float posX[];
float posY[];

int estado[];

//-------------------------------------
//PUNTAJE
PFont fuente;
int puntaje = 0;

void setup() {
  size(650, 600);
  fuente = createFont("ShareTechMono-Regular.ttf", 50);
  //-----------------------------------
  lineaA = height/2;
  
  lineaB = height/2;
  width = 100;
  
  stroke(204, 102, 0);
  lineaC= height/2;
  width = 100;
  //-----------------------------------
  
  posX = new float[20];
  posY = new float[20];
  
  estado = new int[20];
  
  for(int i = 0; i<20; i++)
  {
    posX[i] = random(635);
    posY[i] = random(595);
    
    estado[i] = 1;
  }
}

void draw() {
  background(0);
  //--------------------------------------------------------
  // Lineas
  
  line(0, lineaA, width, lineaA);
  lineaA = lineaA - 4.3;
  if (lineaA < 0) { 
    lineaA = height;
  }
  line(500, lineaB, bw, lineaB);
  lineaB = lineaB - 4;
  if ( lineaB < 0) { 
    lineaB = height;
  }
  line(600, lineaC, cw, lineaC);
  lineaC = lineaC - 4.5;
  if (lineaC < 0) { 
    lineaC = height;
  }
  //--------------------------------------------------------
  //SERPIENTE
  
  strokeWeight(9);
  stroke(255, 100);
  
  dragSegment(0, mouseX, mouseY);
  for(int i=0; i<x.length-1; i++) {
    dragSegment(i+1, x[i], y[i]);
  }
  //--------------------------------------------------------
  //BOLITAS
  
  for(int i = 0; i<20; i++)
  {
    posY[i] = posY[i] + random(0.5,5);
    
    if(posY[i] >=600 || posY[i] <= 0)
    {
      posY[i] = 0;
    }
  }
  
  fill(#FFFFFF);
  for(int i=0; i<20; i++)
  {
    if(estado[i] == 1)
    {
    ellipse(posX[i],posY[i],20,20);
    }
  }
  
  for(int i=0; i<20; i++)
  {
    if(mousePressed == true)
    {
      distancia = dist(mouseX,mouseY,posX[i],posY[i]);
      if(distancia < 20)
      {
        estado[i] = 0;
      }
    }
  }
  
  textFont(fuente, 50);
  fill(#898787);
  text("SCORE :"+puntaje,200,590 );
  puntaje = 0;
  for(int i=0; i<20; i++)
  {
    if(estado[i] == 0)
    {
      puntaje ++;
    }
  }
  
}

void dragSegment(int i, float xin, float yin) {
  float dx = xin - x[i];
  float dy = yin - y[i];
  float angle = atan2(dy, dx);  
  x[i] = xin - cos(angle) * segLength;
  y[i] = yin - sin(angle) * segLength;
  segment(x[i], y[i], angle);
}

void segment(float x, float y, float a) {
  pushMatrix();
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
  popMatrix();
}

/*void mouseMoved()
{
 for(int i = 0; i < 3; i++)
 {
   distancia = dist(mouseX, mouseY, malX[i],malY[i]);
   if(distancia < 2)
   {
     estadoMal[i] = 0;
   }
 }
}*/
