//Comunicação Serial
import processing.serial.*;
Serial porta;
String myString;

//Seleção de Fonte
PFont fonte;

//Seleção de Imagens
PImage play;
PImage fases;
PImage sair;
PImage processing;
PImage moeda;
PImage galaxy;
PImage cadeado2;

//Declaração de Variáveis
int click;
int info;
int page = 0;
int coins = 0;
int pagina2 = 0;
float tempo_exibir = 0;
float temp = 0;
float dado = 0;
float dado2 = 0;
float temp2 = 0;
float jogo = 0;
long record2 = 0;
long record;

//Elementos moveis do programa
Actor actor;
Actor actor2;
Actor actor3;
Actor actor4;
Actor actor5;
Actor actor6;
Actor actor7;
Actor actor8;
Actor actor9;


void setup(){
  
  //porta = new Serial(this, "COM4", 9600);
  //porta.bufferUntil('\n');
  size(1200, 680);    //Dimensão da janela
  frameRate(60);      //Taxa de FPS
  
  //Carregamento de Fonte
  fonte = loadFont("BookAntiqua-Bold-48.vlw");
  textFont(fonte);
  
  //Carregamento de Imagens
  play = loadImage("Comecar.png");
  fases = loadImage("cadeado.png");
  sair = loadImage("sair.png");
  processing = loadImage("processing.png");
  moeda = loadImage("moeda.png");
  galaxy = loadImage("galaxy.jpg");
  cadeado2 = loadImage("cadeado2.png");
  
  //Declaração dos elementos móveis
  actor = new Actor(0, 220, 250, 8, 1.0f, 1.0f);
  actor2 = new Actor(width, 370, 250, 8, 1.0f, 1.0f);
  actor3 = new Actor(0, 220, 250, 8, 1.0f, 1.0f);
  actor4 = new Actor(width, 370, 250, 8, 1.0f, 1.0f);
  actor5 = new Actor(0, 220, 250, 8, 1.0f, 1.0f);
  actor6 = new Actor(width, 370, 250, 8, 1.0f, 1.0f);
  actor7 = new Actor(220, 200, 50, 50, 1.0f, 1.0f);
  actor8 = new Actor(0, 220, 8, 250, 1.0f, 1.0f);
  actor9 = new Actor(width, 370, 8, 250, 1.0f, 1.0f);

}

void draw(){
  
  switch(page){
    
   /*  Tela inicial (o usuário escolhe entre começar o jogo,
       escolher outra fase e sair do programa
   */
   case 0:
    background(#E3C4FF);    
    fill(#6424D3);
    noStroke();
    rect(0, 0, width, 50);
    rect(0, 630, width, 50);
    fill(0, 0, 0);
    textSize(15);
    text("FPS:", width-100, 30);    
    text(frameRate, width-72, 30);      
    image(processing, 20, 8, 40, 40);
    //fill(255, 255, 255);
    textSize(40);
    text("COMEÇAR", 110, 280);
    image(play, 180, 300, 50, 50);
    actor.update(5, 95);
    actor2.update2(50, 100);
    actor.display(0);
    actor2.display(0);
    text("FASES", 550, 280); 
    image(fases, 590, 300, 50, 50);
    actor3.update(20, 470);
    actor4.update2(45, 480);
    actor3.display(0);
    actor4.display(0);
    text("SAIR", 910, 280);
    image(sair, 930, 300, 50, 50);
    actor5.update(50, 850);
    actor6.update2(20, 850);
    actor5.display(0);
    actor6.display(0);
    fill(#6424D3);
    rect(220, 460, 50, 50);
    fill(0);
    rect(0, 480, 60, 130);
    rect(80, 530, 100, 80);
    rect(200, 510, 100, 100);
    rect(320, 480, 100, 130);
    rect(440, 550, 100, 60);
    rect(570, 540, 100, 70);
    rect(690, 480, 100, 130);
    rect(810, 500, 100, 110);
    rect(930, 450, 100, 160);
    rect(1050, 560, 100, 50);
    rect(1170, 500, 50, 110);
    stroke(0);
    if (click == 1){    //Selecionar o início da fase
      fill(0);
      text("SAIR", 910, 280);      
      fill(#6424D3);
      text("COMEÇAR", 110, 280);
      if(keyPressed) page = 1;
    }else if (click == 2){    //Selecionar uma nova tela para escolher outra fase
      fill(0);
      text("COMEÇAR", 110, 280);
      fill(#6424D3);
      text("FASES", 550, 280);
      if(keyPressed) page = 2;
    }else if (click == 3){      //Seleciona a tela anterior
      fill(0);
      text("FASES", 550, 280);
      fill(#6424D3);
      text("SAIR", 910, 280);
      if(keyPressed) page = 3;
    }
    break;
   
   /*  Tela de jogo, utiliza funções secundárias para adicionar,
       remover as paredes e calcular o tempo
   */
   case 1:
     noStroke();
     gameScreen();
     actor7.display(#6424D3);
     actor7.pulo();
     wallAdder();
     wallHandler();
     wallDrawer(0);
     wallMover(0);
     wallRemover(0);
     record = millis();
     textSize(40);
     fill(255, 255, 255);
     text(nf(record/1000),  550, 80);
     if (actor7.y + 50 > 680){      //Se o quadrado se mover para além do eixo horizaontal
       page = 4;                    //o usuário é levado à tela de fim de jogo
     }
     break;
     
   /* Tela para a seleção de uma nova fase, incluindo o mostrador de moedas
   */
   case 2:
     background(#B190EA);
     tint(255, 100);
     image(galaxy, 0, 0, 1200, 680);
     fill(#B190EA);
     noStroke();
     rect(0, 0, width, 50);
     rect(0, 630, width, 50);
     tint(255, 255);
     image(processing, 20, 8, 40, 40);
     fill(0);
     textSize(15);
     text("FPS:", width-100, 30);
     text(frameRate, width-72, 30);
     strokeWeight(10);
     stroke(255,255,255);
     fill(255,255,255);
     textSize(80);
     text("FASE 1",170, 370);
     text("FASE 2",750, 370);
     textSize(30);
     text("RECORD:", 200, 500);
     if(record > record2) record2 = record;
     text(nf(record2/1000), 350, 500);
     text("VOLTAR", width/2 - 50, 665);
     text("5", 855, 500);
     textSize(40);
     text(coins, 170, 120);
     image(moeda, 100, 80, 50, 50);
     image(moeda, 880, 470, 40, 40);
     noFill();
     rect(100, 250, 400, 200, 7);
     rect(680, 250, 400, 200, 7);
     image(cadeado2, 860, 390, 40,50);
     if (click == 2){    //Iniciar novamente o jogo
       strokeWeight(10);
       stroke(255,255,255);
       noFill();
       rect(680, 250, 400, 200, 7);
       stroke(#6424D3);
       rect(100, 250, 400, 200, 7);
       if(keyPressed && pagina2 == 2){
       noStroke();
       page = 1;
       }
     }if (click == 3){    //Selecionar a segunda fase
       strokeWeight(10);
       stroke(255,255,255);
       noFill();
       rect(100, 250, 400, 200, 7);
       stroke(#6424D3);
       rect(680, 250, 400, 200, 7);
       if(keyPressed && pagina2 == 2) text("FASE BLOQUEADA", 690, 200);
     }if (click == 1){    //Voltar à tela inicial
       noStroke();
       fill(#6424D3);
       textSize(30);
       rect(0, 630, width, 50);
       strokeWeight(10);
       stroke(255,255,255);
       fill(255, 255, 255);
       text("VOLTAR", width/2 - 50, 665);
       noFill();
       rect(100, 250, 400, 200, 7);
       rect(680, 250, 400, 200, 7);
       if(keyPressed){
       page = 0;
       pagina2 = 0;
       }
     }
     break;
   
   /*  Sair do programa
   */
   case 3:
     exit();
   
   /* Tela de fim jogo, com apenas uma opção, levando à tela inicial
   */
   case 4:
     background(#B190EA);
     tint(255, 100);
     image(galaxy, 0, 0, 1200, 680);
     tint(255, 255);
     fill(255,255,255);
     textSize(60);
     text("GAME OVER", 400, 310);
     if(mousePressed){    //zerando alguns dados antes de iniciar novo jogo
       actor7.y = 200;
       actor7.playerSpeedY = 0;
       click = 0;
       pagina2 = 0;
       page = 0;
     }
     
}  
}

//Quando uma tecla é pressionada corresponde a um clique duplo
void keyPressed(){
  pagina2++;
  if (pagina2 == 3){
    pagina2 = 2;
  }
}

//Quando o botão do mouse é clicado corresponde a um clique único
void mouseClicked(){ 
  click++;
  if (click == 4){
    click = 1;
  }
}
