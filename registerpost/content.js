

var observer = new MutationObserver(function (mutations, observer) {
    findUrls();
})

observer.observe($('[id^=topnews_main_stream_]').get(0), {
    subtree: true,
    attributes: true
});


function findUrls() {
    counter = 0;
    var urlArray = []
    var links = document.getElementsByClassName('_6ks');
    for (key in links) {
        counter +=1;
        var url = links[key].querySelector('a').href;
        urlArray.push(url);
       if (links[key].childNodes.length < 2) {
            addLabel(links[key]);
       }
    }
}


function addLabel(post) {
    if (counter = 2) {
        counter = 0;
    }
    counter +=1
    var divLabel = document.createElement('div');
    divLabel.id = "status"
    divLabel.style.fontWeight = "bold";
    divLabel.style.position = "absolute";
    divLabel.style.fontSize = "25px";
    divLabel.style.marginLeft = "365px";
    divLabel.style.marginTop = "60px";
    var label = document.createTextNode('Verified');
    divLabel.append(label);
    /*if (counter == 1) {
        label.innerHTML = "Verified"
    } else if (counter == 2) {
        label.innerHTML = "Unverified"
    }*/
    if (divLabel.parentNode != post) {
        post.appendChild(divLabel);
    }
}