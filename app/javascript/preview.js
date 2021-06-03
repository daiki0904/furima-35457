document.addEventListener('DOMContentLoaded',function(){
  if ( document.getElementById('item-image')){
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {
      const ImageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);

      ImageElement.appendChild(blobImage);
      ImageList.appendChild(ImageElement);
    };

    document.getElementById('item-image').addEventListener('change', function(e){
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  }
});