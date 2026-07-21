export function productScripts(product: any): string {
  return `
<script>

const APP_LINK = "teamomart://product/${product.id}";
const PLAY_STORE =
  "https://play.google.com/store/apps/details?id=com.teamomart.app";
const APP_STORE =
  "https://apps.apple.com/app/idXXXXXXXX";

function isAndroid(){
    return /android/i.test(navigator.userAgent);
}

function isIOS(){
    return /iphone|ipad|ipod/i.test(navigator.userAgent);
}

function openInApp(){

    const start = Date.now();

    window.location.href = APP_LINK;

    setTimeout(function(){

        if(Date.now() - start < 1800){

            if(isAndroid()){
                window.location.href = PLAY_STORE;
                return;
            }

            if(isIOS()){
                window.location.href = APP_STORE;
                return;
            }

        }

    },1500);

}

function changeImage(src,element){

    const image=document.getElementById("productImage");

    if(image){
        image.src=src;
    }

    document.querySelectorAll(".thumbnail").forEach(function(item){
        item.classList.remove("active");
    });

    if(element){
        element.classList.add("active");
    }

}

document.addEventListener("DOMContentLoaded",function(){

    const button=document.getElementById("openAppButton");

    if(button){

        button.addEventListener("click",function(e){

            e.preventDefault();

            openInApp();

        });

    }

});

</script>
`;
}