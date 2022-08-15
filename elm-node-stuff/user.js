const fs = require("fs");


function out_cards(content){
    fs.writeFile(`cards_out/${content.fname}`,content.content,err => {
        if (err) {
            console.log(err);
        }else {
            console.log(`File Written, ${content.fname}`);
        }
    });
    
}

module.exports = Elm => {
  const app = Elm.SvgMaker.init();
  app.ports.log?.subscribe(
      (ct)=>{
          out_cards(ct);
          app.ports.nextPage.send(3);
      }
  );
  app.ports.nextPage.send(3);
};
