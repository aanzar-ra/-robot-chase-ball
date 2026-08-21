// RobotChaseBall
// Subject: Robot | Action: Chase | Object: Ball
//
// A robot continuously chases a ball around the canvas.
// When the robot catches the ball, the ball resets to a new random
// position and the score increases. This is the interactive element.

float robotX, robotY;      // robot's current position
float ballX, ballY;        // ball's current position
float robotSpeed = 2.5;    // how fast the robot moves each frame
float robotSize = 40;      // diameter of the robot body
float ballSize = 20;       // diameter of the ball
int score = 0;             // number of times the robot has caught the ball

void setup() {
  size(800, 600);          // create the drawing canvas
  robotX = 100;             // start the robot near the top-left
  robotY = 100;
  resetBall();              // place the ball at a random starting position
}

void draw() {
  background(30, 30, 40);   // dark background, redrawn every frame

  moveRobotTowardsBall();   // update robot position to chase the ball
  checkCollision();         // check if robot has "caught" the ball

  drawBall();
  drawRobot();
  drawScore();
}

// Moves the robot one step closer to the ball's current position.
// Uses simple vector math: direction = target - current, normalised,
// then scaled by robotSpeed.
void moveRobotTowardsBall() {
  float dx = ballX - robotX;             // horizontal distance to ball
  float dy = ballY - robotY;             // vertical distance to ball
  float distance = sqrt(dx * dx + dy * dy); // straight-line distance (Pythagoras)

  if (distance > 1) {                    // avoid divide-by-zero when very close
    float dirX = dx / distance;          // normalised x direction (-1 to 1)
    float dirY = dy / distance;          // normalised y direction (-1 to 1)
    robotX += dirX * robotSpeed;         // step robot towards ball on x axis
    robotY += dirY * robotSpeed;         // step robot towards ball on y axis
  }
}

// Checks whether the robot has reached the ball. If the distance between
// their centres is less than the sum of their radii, they have collided.
void checkCollision() {
  float dx = ballX - robotX;
  float dy = ballY - robotY;
  float distance = sqrt(dx * dx + dy * dy);

  if (distance < (robotSize / 2 + ballSize / 2)) {
    score++;              // increment score on a successful catch
    resetBall();           // move the ball somewhere new
  }
}

// Places the ball at a random position within the canvas, leaving a
// margin so it never spawns partly off-screen.
void resetBall() {
  ballX = random(ballSize, width - ballSize);
  ballY = random(ballSize, height - ballSize);
}

void drawRobot() {
  fill(80, 180, 255);
  noStroke();
  ellipse(robotX, robotY, robotSize, robotSize);
}

void drawBall() {
  fill(255, 120, 80);
  noStroke();
  ellipse(ballX, ballY, ballSize, ballSize);
}

void drawScore() {
  fill(255);
  textSize(20);
  text("Catches: " + score, 20, 30);
}
