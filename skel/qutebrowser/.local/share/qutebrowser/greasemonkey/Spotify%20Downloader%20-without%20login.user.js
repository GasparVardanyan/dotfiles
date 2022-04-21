// ==UserScript==
// @name     Spotify Downloader (without login)
// @name:it  Scarica da Spotify (senza login)
// @version  1.2.0
// @icon data:image/gif;base64,R0lGODlhMAAwAKECAADaXyjXXu0A/+0A/yH5BAEKAAIALAAAAAAwADAAAAL2lI+pwK0PI2wg2Eullu36bznbyICmyYzcyaLqUrWyl75COech8Mb6H+BtfMCfMIIrGo8PolLHTDif0CaLgs1Or4tPRoWVRZ1R26FzYhLLZulWTWsPyWfvRMu+x28gYRaVtYJh8LaVIyK1Z0iDh9Y3Frf4xeGIkUKWZCdXGVToIoeQmfYGCtMiOkhIwYhoNXqFOlqT+MhHNUqrudjZGMZImAYMmAeTGRsi7EVMuZtqu1d6jFzXp9o7GyoZ+nqI/Vy9ffubrBkuzsrVdV41sT6zLO3ure5eO1Sv3IO/YxYPNA9m3TISzWCVclNwx0BQvhQCPIgES6kCADs=
// @author   StephenP
// @namespace StephenP
// @description Download Spotify songs from the context menu of the tracks, without logging in. This script uses Muffon's back-end to retrieve the download links.
// @description:it Scarica le canzoni di Spotify dal menu contestuale delle tracce, senza registrarti. Questo script usa il server di Muffon per ottenere i link dei download.
// @grant    GM_xmlHttpRequest
// @grant    GM.xmlHttpRequest
// @grant    GM_download
// @grant    GM.download
// @grant    GM_setValue
// @grant    GM.setValue
// @grant    GM_getValue
// @grant    GM.getValue
// @connect muffon.endorphine.by
// @connect self
// @require https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js
// @match    https://open.spotify.com/*
// @match    https://files.muffon.endorphine.by/*
// @match    https://muffon.endorphine.by/*
// @compatible firefox
// @compatible chrome
// @compatible edge
// @license AGPL-3.0-or-later
// @run-at document-start
// ==/UserScript==
//This script uses FileSaver.js library (https://github.com/eligrey/FileSaver.js) by Eli Grey for downloads. The following text is its license:
/*The MIT License
Copyright © 2016 Eli Grey.
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*/

var url;
var svcUrl="https://muffon.endorphine.by/api/v1/spotify/tracks/";
var dlIcon=`<path fill="none" stroke="#181818" d="m 9.8828125,3.4804688 c -0.7349901,0 -1.2421875,0.1926045 -1.2421875,1.0924154 v 7.9699008 c 0,1.03426 0.1130902,1.530617 -1.1582031,1.530617 H 5.9296875 c -1.3844487,0 -1.0797671,0.06333 0.15625,1.33106 l 5.2684715,4.979414 c 0.702982,0.582983 0.738466,0.629469 1.451327,-0.04406 l 5.223561,-4.935354 c 1.236017,-1.267739 1.540699,-1.33106 0.15625,-1.33106 h -1.552735 c -1.271293,0 -1.158203,-0.496357 -1.158203,-1.530617 V 4.5728842 c 0,-0.899811 -0.507197,-1.0924154 -1.242187,-1.0924154 l -2.175781,0.020573 z"></path>`;
var corsLocked;
const jsonLocalization=JSON.parse(`
{
    "en": {
        "downloadTrack": "Download track",
        "retrievingLink": "Retrieving download link...",
        "bgDownload": "Downloading in background...",
        "dlFailed": "Download failed!",
        "downloaded": "Downloaded!",
        "noResponse": "No response from Muffon server.",
        "corsExemptionFailed": "Your browser and your userscript manager don't propagate the @connect property: the Spotify Downloader script will switch to a different download method from the next time.",
				"missingLink": "File not available."
	},
    "it": {
        "downloadTrack": "Scarica il brano",
        "retrievingLink": "Recupero il link di download...",
        "bgDownload": "Scarico in secondo piano...",
        "dlFailed": "Scaricamento fallito!",
        "downloaded": "Scaricato!",
        "noResponse": "Nessuna risposta dal server Muffon.",
        "corsExemptionFailed": "Il tuo browser e il tuo gestore di userscript non propagano la proprietà @connect: lo script Scarica da Spotify Downloader passerà a un altro metodo di download dalla prossima volta.",
        "missingLink": "Il file non è disponibile."
    }
}
`);
var l;
(async function(){
  corsLocked=await getCorsBhv();
  let lang=getLang();
  if(lang.startsWith("it")){
    l=jsonLocalization.it;
  }
  else{
    l=jsonLocalization.en;
  }
  if(document.location.href.includes("open.spotify.com")){
      setInterval(checkPageChanged,1000);
  }
  else if(document.location.href.includes("files.muffon.endorphine.by")){
      downloadThis();
  }
})();
async function getCorsBhv(){
  GM.setValue("CORS_locked",false); //disabled, to be enabled only for testing purpose
  return GM.getValue("CORS_locked");
}
function getLang() {
  try{
    if (navigator.languages != undefined)
      return navigator.languages[0];
    return navigator.language;
  }
  catch(e){
    return "en"
  }
}
function checkPageChanged(){
 if(document.location.href!=url){
   console.log("Changed url from "+url+" to "+document.location.toString());
   url=document.location.href;
   const config = { attributes: false, childList: true, subtree: false };//this rough implementation is slower
   const callback = function(mutationsList, observer) {
     for(const mutation of mutationsList) {
       for(const addedNode of mutation.addedNodes){
         console.log(mutation);
         //desktop interface
         if(addedNode.querySelector("[id=context-menu]>[role=menu]")){
           if(document.location.href.includes("/track/")){
            addDlButton(addedNode.querySelector("[id=context-menu]"),1);
           }
           else{
           	addDlButton(addedNode.querySelector("[id=context-menu]"),0);
           }
           break;
         }
         //mobile interface
         else if(addedNode.getAttribute("data-testid")=="context-menu-container"){
           if(document.location.href.includes("/track/")){
            addDlButtonMobile(addedNode.querySelector("[data-testid=context-menu-container]"),1);
           }
           else{
           	addDlButtonMobile(addedNode.querySelector("[data-testid=context-menu-container]"),0);
           }
           break;
         }
       }
     }
   };
   const bodyObserver = new MutationObserver(callback);
   bodyObserver.observe(document.body, config);
 }
}
function addDlButton(contextMenu,mode){
  if(!document.getElementById("dlBtn")){
    console.log("Adding dl button: mode "+mode);
    var goToTrack;
    if(mode===0){
      goToTrack=contextMenu.querySelector("[href*=\\:track\\:]");
    }
    else{
      goToTrack=contextMenu.querySelector("[role=menuitem]");
    }
    if(goToTrack){
      goToTrack=goToTrack.parentNode;
      var dlBtn=goToTrack.cloneNode(true);
      var trackId;
      if(mode===0){
        trackId=dlBtn.firstElementChild.getAttribute("href").substr(dlBtn.firstElementChild.getAttribute("href").indexOf(":track:")+7);
      }
      else{
        trackId=document.location.href.match(/(\/track\/[A-z0-9])\w+/)[0];
        trackId=trackId.substr(trackId.indexOf("/track/")+7)
      }
      dlBtn.firstElementChild.setAttribute("trackId",trackId);
      dlBtn.firstElementChild.removeAttribute("href");
      dlBtn.firstElementChild.addEventListener("click",download);
      dlBtn.firstElementChild.firstElementChild.textContent=l.downloadTrack;
      dlBtn.id="dlBtn";
      goToTrack.parentNode.appendChild(dlBtn);
    }
  }
}
function addDlButtonMobile(contextMenu,mode){
  if(!document.getElementById("dlBtn")){
    console.log("Adding dl button: mode "+mode);
    var goToTracks;
    var trackURL;
    if(mode===0){
      goToTracks=document.body.querySelectorAll("[href*=\\/track\\/]");
    }
    else{
      goToTracks=document.location.pathname;
    }
    if(goToTracks){
      console.log(goToTracks);
      if(mode===0){
        for(let t of goToTracks){
          while(!contextMenu){
            contextMenu=document.querySelector("[data-testid=context-menu-container]");
          }
          var openTrack=contextMenu.getElementsByTagName("SPAN")[0];
          var openArtist=contextMenu.getElementsByTagName("SPAN")[1];
          if(openTrack){
            console.log(t.textContent+" == "+openTrack.textContent);//compare song titles
            try{
              console.log(t.parentNode.parentNode.parentNode.querySelector("[href*=\\/artist\\/]").textContent+" == "+openArtist.textContent);
              if((t.textContent==openTrack.textContent)&&(t.parentNode.parentNode.parentNode.querySelector("[href*=\\/artist\\/]").textContent==openArtist.textContent)){
                trackURL=t.href;
                console.log("TRACK URL: "+trackURL);
                break;
              }
            }
            catch(e){
              console.log("Error comparing song names to select the right track to download");
            }
          }
        }
      }
      else{
        trackURL=goToTracks;
      }
      try{
        while(!contextMenu){
          contextMenu=document.querySelector("[data-testid=context-menu-container]");
        }
        var dlBtn=contextMenu.getElementsByTagName("LI")[0].cloneNode(true);
        var trackId=trackURL.substr(trackURL.indexOf("/track/")+7);
        dlBtn.firstElementChild.setAttribute("trackId",trackId);
        dlBtn.firstElementChild.addEventListener("click",download);
        dlBtn.firstElementChild.lastElementChild.textContent=l.downloadTrack;
        dlBtn.firstElementChild.firstElementChild.innerHTML=dlIcon;
        dlBtn.id="dlBtn";
        contextMenu.getElementsByTagName("LI")[0].parentNode.appendChild(dlBtn);
      }
      catch(e){console.log(e);}
    }
  }
}
function download(event){
  event.stopPropagation();
  var trackId;
  var tgt=event.target;
  while((!trackId)&&(tgt!==document.body)){
    trackId=tgt.getAttribute("trackId");
    if(!trackId){
      tgt=tgt.parentNode;
    }
  }
  if(trackId){
    if(!tgt.firstElementChild.tagName=="SVG"){
    	tgt.firstElementChild.textContent=l.retrievingLink;
    }
    else{
      tgt.lastElementChild.textContent=l.retrievingLink;
    }
    console.log(trackId);
    downloadFromJSON(trackId,tgt);
  }
}
function saveWithBlob(res,tgt){
    saveAs(res.response.track.audio.link, res.response.track.artist.name.replace(/[\\\/:*?"<>|]+/g, "")+" - "+res.response.track.title+".ogg");
    if(!tgt.firstElementChild.tagName=="SVG"){
    	tgt.firstElementChild.textContent=l.bgDownload;
    }
    else{
      tgt.lastElementChild.textContent=l.bgDownload;
    }
}
function downloadFromJSON(trackId,tgt){
    console.log("Track ID: "+trackId);
    if((corsLocked===true)&&(document.location.href.includes("open.spotify.com"))){//if the userscript manager and the browser can't allow a cors even if @connect specifies the allowed domains, the script loads a 404 iframe from the destination site and does the request from there; Considering that on saving a file, browsers download media files from the beginning even when they are already loaded, this should result in the same amount of requests to the file server, but the first one will be just a light 404 page.
      var frm=document.createElement("IFRAME");
      frm.src=svcUrl.replace("https://","https://files.") + trackId;
      frm.style.display="none";
      document.body.appendChild(frm);
    }
    else{
        GM.xmlHttpRequest({
            url: svcUrl + trackId,
            responseType: 'json',
            method: 'GET',
            onload: function(res) {
              if (res.readyState == 4 && res.response.track) {
                console.log("RESPONSE:");
                console.log(res);
                if(res.response.track.audio.link!="https://files.muffon.endorphine.by/"){
                  if((typeof GM_download).toString()==='undefined'){ //Using GM_ instead of GM. as Greasemonkey doesn't have a GM.download method and GM.download wouldn't be recognised by Tampermonkey and Violentmonkey
                    saveWithBlob(res,tgt);
                  }
                  else if(typeof GM_download){
                    GM_download({
                      url: res.response.track.audio.link,
                      name: res.response.track.artist.name.replace(/[\\\/:*?"<>|]+/g, "")+" - "+res.response.track.title+".ogg",
                      onload: function(res) {
                        if(tgt){
                          if(!tgt.firstElementChild.tagName=="SVG"){
                            tgt.firstElementChild.textContent=l.downloaded;
                          }
                          else{
                            tgt.lastElementChild.textContent=l.downloaded;
                          }
                        }
                        console.log(l.downloaded);
                      },
                      onerror: function(error) {
                        if(tgt){
                          if(!tgt.firstElementChild.tagName=="SVG"){
                            tgt.firstElementChild.textContent=l.dlFailed;
                          }
                          else{
                            tgt.lastElementChild.textContent=l.dlFailed;
                          }
                        }
                        else{
                          alert(l.dlFailed);
                        }
                        console.log(l.dlFailed);
                        console.log(error);
                        saveWithBlob(res,tgt);
                      }
                    })
                  }
                  else{
                    saveWithBlob(res,tgt);
                  }
                }
                else{
                  if(tgt){
                    if(!tgt.firstElementChild.tagName=="SVG"){
                      tgt.firstElementChild.textContent=l.missingLink;
                    }
                    else{
                      tgt.lastElementChild.textContent=l.missingLink;
                    }
                  }
                  else{
                    alert(l.missingLink);
                  }
                }
              }
            },
            onerror: function() {
                if(tgt){
                    if(!tgt.firstElementChild.tagName=="SVG"){
                      tgt.firstElementChild.textContent=l.noResponse;
                    }
                  else{
                    tgt.lastElementChild.textContent=l.noResponse;
                  }
                }
                else{
                  alert(l.noResponse);
                }
                console.log(l.noResponse);
            }
        })
    }
}
function downloadThis(){
    if((!corsLocked)||(corsLocked===false)){
        GM.setValue("CORS_locked",true);
        alert(l.corsExemptionFailed);
    }
    else{
        downloadFromJSON(document.location.href.substr(document.location.href.indexOf("tracks/")+7),null);
    }
}