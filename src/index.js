'use strict';

var fs = require('fs');
var myapp = Elm.Showdron.embed(document.getElementById('main'));
var {ipcRenderer, remote} = require('electron');

myapp.ports.requestDirList.subscribe(requestDirList);

function requestDirList(dir) {
    fs.readdir(dir, (err, files) => {
        // TODO handle errors
        myapp.ports.dirListResponse.send(files);
    });
}
