var GitHubApi = require("github");
var _ = require('lodash');
var semver = require('semver');
var fs = require('fs');

var github = new GitHubApi({
    // required
    version: "3.0.0",
    // optional
    debug: false,
    protocol: "https",
    host: "api.github.com", // should be api.github.com for GitHub
    //pathPrefix: "/api/v3", // for some GHEs; none for GitHub
    timeout: 5000,
    headers: {
        "user-agent": "github-release-check" // GitHub is happy with a unique user agent
    }
});

https://api.github.com/repos/atom/atom/releases/latest

github.releases.listReleases({
    // optional:
    // headers: {
    //     "cookie": "blahblah"
    // },
    owner: "atom",
    repo: "atom",
    page: 0,
    per_page: 30
}, function(err, res) {

    res = _.first(_.where(res, {prerelease: false}));

    var asset =
      _.chain(res.assets).filter( function(x){
        return _.endsWith(x.name,'.deb');
      }).first().value();

    res = {
      name: res.name,
      branch: getXVer(res.name),
      branchVersion : "'&#123;" + JSON.stringify({
        source_type: 'Branch',
        source_name: getXVer(res.name)
      }) + "&#125;'",
      fileName: asset.name,
      url: asset.browser_download_url
    }

    if(_.any(res,_.isEmpty)){
      throw new Error("Something is empty")
    }

    var env = _.reduce(res, function(r,x,k){
      return r + _.snakeCase(k).toLocaleUpperCase() + '=' + x + "\n"
    }, '');

    fs.writeFileSync('env.sh', '#!/bin/sh\n\n'.concat(env));

    _.templateSettings.interpolate = /{{([\s\S]+?)}}/g;
    var DockerFile = _.template(fs.readFileSync('./templates/Dockerfile'));

    fs.writeFileSync('Dockerfile', DockerFile(res));

});

function getXVer(ver){
  return 'v' + [semver.major(ver), semver.minor(ver), 'x'].join('.');
}
