const { install } = require('cypress-mochawesome-reporter/plugin');

module.exports = (on, config) => {
  install(on);
  return config;
};
