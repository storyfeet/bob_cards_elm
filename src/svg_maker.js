const fs = require("fs");

module.exports = Elm => {
  const app = Elm.SvgMaker.init();
  app.ports.log && app.ports.log.subscribe(out_cards);
};

function out_cards(content){
    fs.writeFile("cards_out/cards1.svg",content,err => {
        if (err) {
            console.log(err);
        }else {
            console.log("File Written");
        }
    });
}

