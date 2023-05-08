"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[671],{3905:(e,t,n)=>{n.d(t,{Zo:()=>u,kt:()=>m});var r=n(67294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var c=r.createContext({}),s=function(e){var t=r.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},u=function(e){var t=s(e.components);return r.createElement(c.Provider,{value:t},e.children)},p="mdxType",d={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},y=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,c=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),p=s(n),y=a,m=p["".concat(c,".").concat(y)]||p[y]||d[y]||o;return n?r.createElement(m,i(i({ref:t},u),{},{components:n})):r.createElement(m,i({ref:t},u))}));function m(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,i=new Array(o);i[0]=y;var l={};for(var c in t)hasOwnProperty.call(t,c)&&(l[c]=t[c]);l.originalType=e,l[p]="string"==typeof e?e:a,i[1]=l;for(var s=2;s<o;s++)i[s]=n[s];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}y.displayName="MDXCreateElement"},59881:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>i,default:()=>d,frontMatter:()=>o,metadata:()=>l,toc:()=>s});var r=n(87462),a=(n(67294),n(3905));const o={sidebar_position:1},i="Getting Started",l={unversionedId:"intro",id:"intro",title:"Getting Started",description:"I thankfully can say installing this package is actually quite easy regardless of your method of choice!",source:"@site/docs/intro.md",sourceDirName:".",slug:"/intro",permalink:"/Sequence/docs/intro",draft:!1,editUrl:"https://github.com/EnDarke/Sequence/edit/main/docs/intro.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"defaultSidebar",next:{title:"Examples",permalink:"/Sequence/docs/example"}},c={},s=[{value:"Wally Dependencies (Recommended)",id:"wally-dependencies-recommended",level:2},{value:"What now?",id:"what-now",level:4},{value:"Source",id:"source",level:2}],u={toc:s},p="wrapper";function d(e){let{components:t,...n}=e;return(0,a.kt)(p,(0,r.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"getting-started"},"Getting Started"),(0,a.kt)("p",null,"I thankfully can say installing this package is actually quite easy regardless of your method of choice!"),(0,a.kt)("h2",{id:"wally-dependencies-recommended"},"Wally Dependencies (Recommended)"),(0,a.kt)("p",null,"Wally is a quick way to get the packages you need! Wally is a package manager for Roblox created by, Uplift Games. This allows us to pull whatever package within the database at any time!"),(0,a.kt)("p",null,"You can install Wally ",(0,a.kt)("a",{parentName:"p",href:"https://wally.run/"},"here")),(0,a.kt)("h4",{id:"what-now"},"What now?"),(0,a.kt)("p",null,"You can now get to configuring your Wally files! Once you make sure Wally is installed on your computer. Run ",(0,a.kt)("inlineCode",{parentName:"p"},"wally init")," in your terminal whilst within your project directory. Open up  the file ",(0,a.kt)("inlineCode",{parentName:"p"},"wally.toml")," to see the configuration settings for Wally. Then, under dependencies add the code ",(0,a.kt)("inlineCode",{parentName:"p"},'Sequence = "endarke/sequence@^0.*"'),".\nOnce you've added the package to your dependencies. You're gonna want to run ",(0,a.kt)("inlineCode",{parentName:"p"},"wally install")," in your terminal."),(0,a.kt)("p",null,(0,a.kt)("inlineCode",{parentName:"p"},"wally.toml")," should look something like this:"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre"},'[package]\nname = "your_name_here/repository_name"\nversion = "0.1.0"\nregistry = "https://github.com/UpliftGames/wally-index"\nrealm = "shared"\n\n[dependencies]\nSequence = "endarke/sequence@^0.*"\n')),(0,a.kt)("h2",{id:"source"},"Source"),(0,a.kt)("p",null,"If you don't have Wally or aren't too interested in using Wally, fear not! You are ",(0,a.kt)("em",{parentName:"p"},"also")," able to download the latest version directly from the Sequence Repository ",(0,a.kt)("a",{parentName:"p",href:"https://github.com/EnDarke/Sequence/releases"},"here"),"!"))}d.isMDXComponent=!0}}]);