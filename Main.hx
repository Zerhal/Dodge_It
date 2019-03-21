import h2d.Bitmap;
import hxd.Key;

   class Main extends hxd.App {

        var firstBar : h2d.Bitmap;
        var secondBar : h2d.Bitmap;
        var ball : h2d.Bitmap;
        var firstDirectionX : Float;
        var firstDirectionY : Float;
        var ySpeed : Float;
        var xSpeed : Float;
        var gameOver : Bool;
        var scr1 : Int;
        var scr2 : Int;

        override function init() {

            var tile = h2d.Tile.fromColor(0xFFFFFF, 20, 200); // Ajout de la forme des barre
            var tileBall = h2d.Tile.fromColor(0xFFFFFF, 20, 20); // Ajout de la forme de la balle
            
            // Titre
            var font : h2d.Font = hxd.res.DefaultFont.get(); 
            var titre = new h2d.Text(font);
            titre.text = "PONG";
            titre.textAlign = Center;
            titre.x = s2d.width * 0.5;
            titre.y = s2d.height * 0.1;
            s2d.addChild(titre);

            // Scores 1
            var score1 = new h2d.Text(font);
            score1.text = "Joueur 1 : ";
            score1.textAlign = Center;
            score1.x = s2d.width * 0.2;
            score1.y = s2d.height * 0.15;
            s2d.addChild(score1);

            // Scores 2
            var score2 = new h2d.Text(font);
            score2.text = "Joueur 2 :";
            score2.textAlign = Center;
            score2.x = s2d.width * 0.8;
            score2.y = s2d.height * 0.15;
            s2d.addChild(score2);

            // Ajout des element  Barres et ball
            firstBar = new h2d.Bitmap(tile, s2d);
            secondBar = new h2d.Bitmap(tile, s2d);
            ball = new h2d.Bitmap(tileBall, s2d);

            // Placement à l'écrant des different element 
            firstBar.x = s2d.width * 0.1;
            secondBar.x = s2d.width * 0.9;
            firstBar.y = s2d.height * 0.5;
            secondBar.y = s2d.height * 0.5;
            ball.x = s2d.width * 0.5;
            ball.y = s2d.height * 0.5;

            // Jet Aléatoir
            firstDirectionX = Math.random();
            firstDirectionY = Math.random();
            ySpeed = Math.random() * 3;
            xSpeed = Math.random() * 3;

            // Bool
            gameOver == false;
        }

        override function update(dt:Float) {

            // Controle Bar Gauche Clavier : "S" pour descendre "Z" Pour Monter 
           if (Key.isDown(Key.S)) {
                firstBar.y += 1;
            } else if (Key.isDown(Key.Z)){
                firstBar.y -= 1 ;
            }
            if (Key.isDown(Key.UP)) {
                secondBar.y -= 1;
            } else if (Key.isDown(Key.DOWN)){
                secondBar.y += 1 ;
            }

            // Vitesse de la balle
            ball.x -= xSpeed ;
            ball.y -= ySpeed ;


            //  Rebond
            
            // Rebond mur du haut
            if(ball.y <= s2d.height * 0.05){
                ySpeed = ySpeed * -1;  
            }
            
            // Rebond mur du bas
            if(ball.y >= s2d.height * 0.95){
                ySpeed = ySpeed * -1;  
            }

            // Rebond Premiere  Bar
            if((ball.x <= (firstBar.x + 20) ) && (ball.y >= firstBar.y) && (ball.y <= firstBar.y+200)){
                xSpeed = xSpeed * -1;  
            }

            // Rebond Seconde  Bar
            if((ball.x >= (secondBar.x - 20) ) && (ball.y >= secondBar.y) && (ball.y <= secondBar.y+200)){
                xSpeed = xSpeed * -1;  
            }

            //Sortie de ball

            //Gauche
            if(ball.x <  firstBar.x){
                gameOver == true;
                // score +1
                scr2 += 1;
                var scr2Text : String;
                scr2Text = Std.string(scr2);                

                // repositionnement de la ball
                ball.x = s2d.width * 0.5;
                ball.y = s2d.height * 0.5;

            }

           
        }
        static function main() {
            new Main();
        }
    }