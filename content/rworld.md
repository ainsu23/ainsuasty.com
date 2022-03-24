---
---

<style type="text/css">

.wrapper_modificado {
  position: absolute;
  bottom: 110%;
  left: 100%;
  width: 300px;
  height: 500px;
  perspective: 900px;
}

.contenedor {
  position: absolute;
  width: 100%;
  height: 100%;
  transition: .5s all ease;
  transform: rotateX(60deg) scale(0.7);
  perspective: 900px;
  box-shadow: 0px 20px 50px #555;
  animation: entry 1s linear 1;
}

#color-fill {
    fill: #11517d;
}

#c0 {
  position: absolute;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, #59476f 30%, #7b88d1 100%);
  z-index: 300;
  box-shadow: 0px 20px 100px #555;
}

#c1 {
  background: linear-gradient(to bottom, #59476f 30%, #7b88d1 100%);
  box-shadow: 0px 20px 100px #555;
  left: 100%;
  z-index: 0;
}

#c2 {
  left: -100%;
  z-index: 0;
  background: linear-gradient(to bottom, #59476f 30%, #7b88d1 100%);
  box-shadow: 0px 20px 100px #555;
}

.contenedor:hover {
  cursor: pointer;
  transform: rotate(0deg) scale(1) translateY(10px);
  transition: .5s all ease;
  z-index: 400;
}

.image {
  position: absolute;
  top: 0%;
  left: 0%;
  width: 100%;
  height: 45%;
  background: linear-gradient(to top, #eba65b 30%, #d99267 100%);
}

#i1 {
  background: linear-gradient(to top, #686870d1 0%, #9c9ca6d1 120%);
}

#i2 {
  background: linear-gradient(to top, #686870d1 0%, #9c9ca6d1 120%);

}

span {
  position: absolute;
  top: 0%;
  left: 55%;
  border-radius: 100%;
  background-color: #fff;
  z-index: 10;
}



.story {
  position: absolute;
  top: 45%;
  left: 0%;
  height: 55%;
  width: 100%;
  background: linear-gradient(to bottom, #eba65b 0%, #d99267 40%);
  z-index: 30;
}

#s1 {
  background: linear-gradient(to top, #686870d1 0%, #9c9ca6d1 120%);
}

#s2 {
  background: linear-gradient(to top, #686870d1 0%, #9c9ca6d1 120%);
}

.info {
  position: absolute;
  top: 10%;
}

h4 {
  color: #111;
  position: fixed;
  top: 70%;
  left: 0%;
  letter-spacing: 2px;
  z-index: 30;
}

h1 {
  color: #111;
  position: fixed;
  top: 20%;
  left: 50%;
  letter-spacing: 2px;
}

.page {
  position: absolute;
  top: 80%;
  width: 100%;
  left: 0%;
  height: 20%;
  z-index: 30;
}

@keyframes simple {
  50% {
    transform: translateX(10px);
    opacity: 0.5;
  }
  100% {
    transform: translateX(10px);
    opacity: 0;
  }
}

@keyframes simple1 {
  50% {
    transform: translateX(-10px);
    opacity: 0.5;
  }
  100% {
    transform: translateX(-10px);
    opacity: 0;
  }
}

@keyframes entry {
  0% {
    top: -20%;
    opacity: 0.1;
  }
  100% {
    top: 0%;
  }
}

</style>

<html>
<body>
<h1> 3 World places to visit this year</h1>
<div class="wrapper_modificado">
    <div class="contenedor" id="c0">
        <div class="image" id="i1">
            <a href = "https://ainsuasty.com/posts/">
              <svg id="color-fill" xmlns="http://www.w3.org/2000/svg" version="1.1" width="100%" height="300" xmlns:xlink="http://www.w3.org/1999/xlink">
              <polygon class="hex" points="300,100 300,240 0,240 0,100 155,0 155,0"></polygon>
              <text x="150" y="170" font-size="60" text-anchor="middle" fill="white">Blog</text>
              </svg>
            </a>
        </div>
        <div class="story" id="s2">
            <div class="info">
                <h3>  Blogging is fun</h3>
                <p>  R posts related to programming, shiny, data bases, among others. </p>
            </div>
        </div>
    </div>
    <div class="contenedor" id="c1">
        <div class="image" id="i1">
            <a href = "https://ainsuasty.com/projects/">
              <svg id="color-fill" xmlns="http://www.w3.org/2000/svg" version="1.1" width="100%" height="300" xmlns:xlink="http://www.w3.org/1999/xlink">
              <polygon class="hex" points="300,100 300,240 0,240 0,100 155,0 155,0"></polygon>
              <text x="150" y="170" font-size="60" text-anchor="middle" fill="white">Projects</text>
              </svg>
            </a>
        </div>
        <div class="story" id="s2">
            <div class="info">
                <h3> Projects </h3>
                <p>R Company projects where I have been involved. </p>
            </div>
        </div>
    </div>
    <div class="contenedor" id="c2">
        <div class="image" id="i1">
            <a href = "https://ainsuasty.com/shiny/">
              <svg id="color-fill" xmlns="http://www.w3.org/2000/svg" version="1.1" width="100%" height="300" xmlns:xlink="http://www.w3.org/1999/xlink">
              <polygon class="hex" points="300,100 300,240 0,240 0,100 155,0 155,0"></polygon>
              <text x="150" y="170" font-size="60" text-anchor="middle" fill="white">Shiny</text>
              </svg>
            </a>
        </div>
        <div class="story" id="s2">
            <div class="info">
                <h3> Shiny portfolio </h3>
                <p> Apps developed in shiny: Mastering shiny and learning polish, soon more... </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
