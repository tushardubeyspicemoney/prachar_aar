
/*close mobile Browser*/
function CloseSession() {
    app.CloseSession();
}


/*pass some argument*/
/*function SuccessTraining(param1, param2, param3,param4) {
    app.SuccessTraining(param1, param2, param3,param4);
}*/


function clearWebBrowser() {
    app.clearWebBrowser();
}

function experierCalled(param1, param2, param3) {
    app.experierCalled(param1, param2, param3);
}

function DownloadBanner(param1, param2, param3) {
    console.log("DownloadBanner JS Callback");
    app.DownloadBanner(param1, param2, param3);
}




/*Close tab*/
function closeWindow() {
/*var myWindow = window.open("www.google.com", "_self");
  setTimeout (function() {myWindow.close();},1000);*/
     /* var win=window.open('',"_self");
      window.close();*/
      try
      {
        window.close();
      }
      catch(e)
      {
        console.log(e)
      }
            try
            {
              self.close();
            }
            catch(e)
            {
              console.log(e)
            }


}

/*Back browser stack */
function backWindow() {

      try
      {
        history.back()
      }
      catch(e)
      {
        console.log(e)
      }


}

/*async function fetchAndResizeImage(bytes) {

  *//*var byteCharacters = atob(bytes);
  var byteNumbers = new Array(byteCharacters.length);
  for (let i = 0; i < byteCharacters.length; i++) {
      byteNumbers[i] = byteCharacters.charCodeAt(i);
  }
  var byteArray = new Uint8Array(byteNumbers);

  var blob = new Blob([byteArray], { type: 'image/jpeg' });*//*

  //var blob = new Blob([bytes], { type: 'image/jpeg' });

  //const response = await fetch(url);
  //var blob = await response.blob();

  //const content = new Uint8Array(bytes);

  console.log(bytes);


  //const block = bytes.split(';');
    // Get the content type of the image
    //const contentType = block[0].split(':')[1]; // In this case "image/gif"
    // get the real base64 content of the file
    //const realData = block[1].split(',')[1];

  var sliceSize = 1024;
      var byteCharacters = atob(bytes);
      var bytesLength = byteCharacters.length;
      var slicesCount = Math.ceil(bytesLength / sliceSize);
      var byteArrays = new Array(slicesCount);

      for (var sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
          var begin = sliceIndex * sliceSize;
          var end = Math.min(begin + sliceSize, bytesLength);

          var bytes = new Array(end - begin);
          for (var offset = begin, i = 0; offset < end; ++i, ++offset) {
              bytes[i] = byteCharacters[offset].charCodeAt(0);
          }
          byteArrays[sliceIndex] = new Uint8Array(bytes);
      }

     var blob = new Blob(byteArrays, { type: 'image/jpeg' });



  const bitmap = await createImageBitmap(blob);


  const maxWidth = 1920.0; // set max sizes
  const maxHeight = 1080.0;

  console.log(`Width: ${bitmap.width}; Height: ${bitmap.height}`);

  // this simple routine makes sure that the resized image fully fits inside the box specified by max sizes while maintaining proportions
  var targetWidth = null;
  var targetHeight = null;
  if (bitmap.width > maxWidth) {
    targetWidth = maxWidth;
    const calcHeight = (targetHeight = Math.floor(
      bitmap.height * (targetWidth / bitmap.width)
    ));
    if (calcHeight > maxHeight) {
      targetHeight = maxHeight;
      targetWidth = Math.floor(targetWidth * (targetHeight / calcHeight));
    }
  } else if (bitmap.height > maxHeight) {
    targetHeight = maxHeight;
    const calcWidth = (targetWidth = Math.floor(
      bitmap.width * (targetHeight / bitmap.height)
    ));
    if (calcWidth > maxWidth) {
      targetWidth = maxWidth;
      targetHeight = Math.floor(targetHeight * (targetWidth / calcWidth));
    }
  }

  console.log(`Target width: ${targetWidth}; Target height: ${targetHeight}`);

  if (targetWidth != null && targetHeight != null) {
    const canvas = document.createElement("canvas");
    canvas.width = targetWidth;
    canvas.height = targetHeight;

    const _pica = pica();
    blob = await _pica.toBlob(await _pica.resize(bitmap, canvas), "image/jpeg");
  }

  const buffer = await blob.arrayBuffer();

  return { buffer: buffer, mimeType: blob.type };
}*/

async function fetchAndResizeImage(bytes) {


  var sliceSize = 1024;
      var byteCharacters = atob(bytes);
      var bytesLength = byteCharacters.length;
      var slicesCount = Math.ceil(bytesLength / sliceSize);
      var byteArrays = new Array(slicesCount);

      for (var sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
          var begin = sliceIndex * sliceSize;
          var end = Math.min(begin + sliceSize, bytesLength);

          var bytes = new Array(end - begin);
          for (var offset = begin, i = 0; offset < end; ++i, ++offset) {
              bytes[i] = byteCharacters[offset].charCodeAt(0);
          }
          byteArrays[sliceIndex] = new Uint8Array(bytes);
      }

     var blobNew = new Blob(byteArrays, { type: 'image/jpeg' });


  var sizeInMb=(blobNew.size/1000000).toFixed(2);
  //console.log("Bytes At Js Before Compress.....")
  //console.log(sizeInMb)

  if(sizeInMb>10 && sizeInMb<12)
  {
    var factor = 0.4/sizeInMb;
  }

   else if(sizeInMb>13 && sizeInMb<31)
          {

             var factor = 0.1/sizeInMb;

          }


  else if(sizeInMb>0.5 && sizeInMb<1)
        {
          var factor = 0.5;
        }
  else if(sizeInMb>1 && sizeInMb<2)
      {
        var factor = 0.8/sizeInMb;
      }
  else if(sizeInMb>2 && sizeInMb<5)
    {

      var factor = 0.6/sizeInMb;

    }
  else if(sizeInMb>5 && sizeInMb<10)
  {

   var factor = 0.3/sizeInMb;

  }
  else
  {
    var factor = 0.6;

  }


  //console.log('....factor......')
  //console.log(factor)

  const imageBitmap = await createImageBitmap(blobNew);

  const canvas = document.createElement("canvas");

   console.log(`Width: ${imageBitmap.width}; Height: ${imageBitmap.height}`);

      canvas.width = imageBitmap.width;
      canvas.height = imageBitmap.height;
      const ctx = canvas.getContext('2d');
      ctx.drawImage(imageBitmap, 0, 0);


           const blob = await new Promise((resolve) =>
               canvas.toBlob(resolve, 'image/jpeg', factor)
           );



  //const buffer = await blobNew.arrayBuffer();
  const buffer = await blob.arrayBuffer();

  //return { buffer: buffer, mimeType: blobNew.type };
  return { buffer: buffer, mimeType: blob.type };
}



