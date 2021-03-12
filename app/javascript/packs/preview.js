// if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {

  document.addEventListener('DOMContentLoaded', function() {
    const image = document.querySelector('#image_preview');

    const createImg = (blob) => {
      const imageEl = document.createElement('div');
      const blobImg = document.createElement('img');

      blobImg.setAttribute('src', blob);
      imageEl.appendChild(blobImg);
      image.appendChild(imageEl);

    }
    document.querySelector('#room_image').addEventListener('change', function(e) {

      const imgContent = document.querySelector('img');
      if (imgContent) {
        imgContent.remove();
      }
      const pRemove = document.querySelector('.remove')
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImg(blob)
      pRemove.remove();
    })
  })

// }