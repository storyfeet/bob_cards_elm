
module.exports = Elm => {
  const app = Elm.SvgMaker.init();
  app.ports.log && app.ports.log.subscribe(console.log);
};

