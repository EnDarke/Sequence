"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[402],{3905:(e,n,t)=>{t.d(n,{Zo:()=>s,kt:()=>f});var r=t(67294);function a(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function o(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function c(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?o(Object(t),!0).forEach((function(n){a(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):o(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function u(e,n){if(null==e)return{};var t,r,a=function(e,n){if(null==e)return{};var t,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||(a[t]=e[t]);return a}(e,n);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(a[t]=e[t])}return a}var l=r.createContext({}),i=function(e){var n=r.useContext(l),t=n;return e&&(t="function"==typeof e?e(n):c(c({},n),e)),t},s=function(e){var n=i(e.components);return r.createElement(l.Provider,{value:n},e.children)},d="mdxType",p={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},m=r.forwardRef((function(e,n){var t=e.components,a=e.mdxType,o=e.originalType,l=e.parentName,s=u(e,["components","mdxType","originalType","parentName"]),d=i(t),m=a,f=d["".concat(l,".").concat(m)]||d[m]||p[m]||o;return t?r.createElement(f,c(c({ref:n},s),{},{components:t})):r.createElement(f,c({ref:n},s))}));function f(e,n){var t=arguments,a=n&&n.mdxType;if("string"==typeof e||a){var o=t.length,c=new Array(o);c[0]=m;var u={};for(var l in n)hasOwnProperty.call(n,l)&&(u[l]=n[l]);u.originalType=e,u[d]="string"==typeof e?e:a,c[1]=u;for(var i=2;i<o;i++)c[i]=t[i];return r.createElement.apply(null,c)}return r.createElement.apply(null,t)}m.displayName="MDXCreateElement"},5555:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>l,contentTitle:()=>c,default:()=>p,frontMatter:()=>o,metadata:()=>u,toc:()=>i});var r=t(87462),a=(t(67294),t(3905));const o={sidebar_position:3},c="Examples",u={unversionedId:"example",id:"example",title:"Examples",description:"Here are just a few examples of where I believe this module can be of great use!",source:"@site/docs/example.md",sourceDirName:".",slug:"/example",permalink:"/Sequence/docs/example",draft:!1,editUrl:"https://github.com/EnDarke/Sequence/edit/main/docs/example.md",tags:[],version:"current",sidebarPosition:3,frontMatter:{sidebar_position:3},sidebar:"defaultSidebar",previous:{title:"Getting Started",permalink:"/Sequence/docs/intro"}},l={},i=[{value:"Battle Turn Sequence",id:"battle-turn-sequence",level:3},{value:"Round System",id:"round-system",level:3},{value:"Compacting a Network Package",id:"compacting-a-network-package",level:3}],s={toc:i},d="wrapper";function p(e){let{components:n,...t}=e;return(0,a.kt)(d,(0,r.Z)({},s,t,{components:n,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"examples"},"Examples"),(0,a.kt)("p",null,"Here are just a few examples of where I believe this module can be of great use!"),(0,a.kt)("h3",{id:"battle-turn-sequence"},"Battle Turn Sequence"),(0,a.kt)("p",null,"You can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"Sequence")," module to run a turn-based game for players or mobs! Feel free to sort it however you'd like, the possibilities are endless!"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},'local TurnSequence = Sequence.new({ Autotick = false }, function(playerAttacks: {})\n    for _, playerAttack in playerAttacks do\n        -- Yield to perform player actions\n        playerAttack()\n    end\nend)\n\n-- Player 1\nTurnSequence:Includes(function()\n    PlayerService:CastSpell("Regeneration")\nend)\n\n-- Player 2\nTurnSequence:Includes(function()\n    PlayerService:Attack("Kobald")\nend)\n\n-- Player 3\nTurnSequence:Includes(function()\n    PlayerService:Move("Forward", 1) -- Maybe moves have higher priority than attacks?\nend)\n\n-- When it comes to player turn sequence\nTurnSequence:ForceTick()\n')),(0,a.kt)("h3",{id:"round-system"},"Round System"),(0,a.kt)("p",null,"By turning off Autotick and ClearOnTick, we're able to call when we want our sequence to run. As well as, the functions don't get removed after being put through the ",(0,a.kt)("inlineCode",{parentName:"p"},"tick cycle"),". This way, we can continue running the rounds recursively! You can also stop the round at anytime by using ",(0,a.kt)("inlineCode",{parentName:"p"},":Clean()"),"."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},"local currentRound = 1\n\nlocal RoundSequence = Sequence.new({ Autotick = false, ClearOnTick = false }, function(roundSequence)\n    for _, roundFunc in roundSequence do\n        roundFunc(currentRound)\n    end\n    \n    currentRound += 1\nend)\n\n-- Intermission\nRoundSequence:Includes(function(currentRound)\n    -- Notify intermission timer\nend)\n\n-- Start Round\nRoundSequence:Includes(function(currentRound)\n    -- Teleport players into arena\n    -- Spawn all weapons\nend)\n\n-- In-Game Match\nRoundSequence:Includes(function(currentRound)\n    -- Listen for player attacks\n    -- Notify match countdown timer\nend)\n\n-- Reward Players\nRoundSequence:Includes(function(currentRound)\n    -- Give winner rewards\nend)\n\n-- Match End\nRoundSequence:Includes(function(currentRound)\n    -- Restart the match!\n    RoundSequence:ForceTick()\nend)\n\nRoundSequence:ForceTick()\n")),(0,a.kt)("h3",{id:"compacting-a-network-package"},"Compacting a Network Package"),(0,a.kt)("p",null,"You can also successfully group tons of information that you'd like to send across to client(s)!"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},'local Package = Sequence.new({ Autotick = true }, function(packageLoad)\n    PackageRemote:FireAllClients(packageLoad)\nend)\n\nPackage:Includes("Purchase Success!")\nPackage:Includes({\n    PetName = "Dog",\n    PetId = 3,\n})\n')))}p.isMDXComponent=!0}}]);