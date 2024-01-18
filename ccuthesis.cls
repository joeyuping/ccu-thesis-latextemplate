% author: 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ccuthesis}[2024/01/20 Thesis template for National Chung Cheng University]

% Class 選項設定與預設值
\DeclareRobustCommand{\@setspacing}{\onehalfspacing}
\DeclareOption{singlespacing}{\gdef\@setspacing{\singlespacing}}
\DeclareOption{doublespacing}{\gdef\@setspacing{\doublespacing}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,12pt]{article}

\RequirePackage{xeCJK} % 中文支援
\RequirePackage{setspace} % 行距調整

\RequirePackage[top=2.54cm,bottom=2.54cm,left=3.17cm,right=3.17cm%
  ,headheight=1.5cm,footskip=0.6cm]{geometry}

% \RequirePackage[contents={}]{background}

% ====================  表格相關  ====================
\RequirePackage{booktabs}
\RequirePackage{multirow} % 表格跨欄
\RequirePackage{caption} 
\captionsetup[table]{skip=5pt}
\RequirePackage{threeparttable}
\RequirePackage{tabularx}


\RequirePackage{indentfirst}
% \RequirePackage{times}
% \RequirePackage{verbatim}
% \RequirePackage{color}
\RequirePackage{url}
\RequirePackage{graphicx}
\RequirePackage{array}
% \RequirePackage{wallpaper} 
\RequirePackage{amsmath}
\RequirePackage{amssymb} % \mathbb{R}

\RequirePackage{cite} % 使連續的引用可以變成破折號\cite{newcombe2011dtam,engel2014lsd,engel2018direct} ex [4][5][6] => [4-6]
\RequirePackage{notoccite}  % 引用編號時忽略圖目錄裡出現的引用 Ignore citations in captions in list of figures when numbering  https://tex.stackexchange.com/questions/36304/ignore-citations-in-captions-in-list-of-figures-when-numbering

\RequirePackage[colorlinks=true,linkcolor=black,filecolor=black,urlcolor=black,citecolor=black]{hyperref}  

% Declarations
\DeclareRobustCommand{\university}[1]{\gdef\@university{#1}}
\DeclareRobustCommand{\college}[1]{\gdef\@college{#1}}
\DeclareRobustCommand{\type}[1]{\gdef\@type{#1}}
\DeclareRobustCommand{\title}[2]{\gdef\@titlezh{#1}\gdef\@titleen{#2}}
\DeclareRobustCommand{\author}[1]{\gdef\@author{#1}}
\DeclareRobustCommand{\advisor}[1]{\gdef\@advisor{#1}}
\DeclareRobustCommand{\defensedate}[1]{\gdef\@defensedate{#1}}

\DeclareRobustCommand{\makecover}{
  \begin{titlepage}
    \vspace{1.46cm}
    \begin{center}
      \fontsize{28}{42}\selectfont
      \@university\@college\par
        \@type\par
      \vspace{\fill}
      \fontsize{18}{27}\selectfont
      \@titlezh\par
      \@titleen\par
      \vspace{2cm}
      \@author\\
      \vspace{\fill}
      \@advisor \\
      \vspace{1.5cm}
      \@defensedate
    \end{center}
    \vspace{0.46cm}
  \end{titlepage}
}


% ====================  浮水印  ====================
\RequirePackage{fancyhdr} % 借用此套件來擺放浮水印  設定頁首頁尾用的套件
\pagestyle{fancy} % 啟動 fancy header/footer 套件

\newsavebox{\mywatermark}
\sbox{\mywatermark}{\includegraphics[keepaspectratio,width=5cm]{CCU.pdf}}

% 將 central header 擺放浮水印的巨集指令
\DeclareRobustCommand{\PlaceWaterMark}{\fancyhead[C]{\setlength{\unitlength}{1in}%
\begin{picture}(0,0)%
\put(-0.9,-6.25){\usebox{\mywatermark}} % 圖檔擺放的位置座標
\end{picture}}
}

\fancypagestyle{PlainWaterMark}{
\fancyhead{}
\PlaceWaterMark
\fancyfoot{}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
}

% ================ 中文化 ================
% 中文化章節名稱
\RequirePackage{titlesec}
\RequirePackage{xCJKnumb}
\titleformat{\section}
  {\Large\bfseries\filcenter}
  {\textbf{第\,\xCJKnumber{\thesection}\,章}}{1em}{}

\RequirePackage{titletoc}
\titlecontents{section}[1em]{\addvspace{1em}}
{\contentspush{第\,\xCJKnumber{\thecontentslabel}\,章\ \ }}
{}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{subsection}[3em]{\addvspace{1em}}
{\contentspush{\thecontentslabel\ \ }}
{}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{subsubsection}[6em]{\addvspace{1em}}
{\contentspush{\thecontentslabel\ \ }}
{}{\titlerule*[8pt]{.}\contentspage}

\RequirePackage{tocloft}
\renewcommand{\cftfigfont}{圖 }
\renewcommand{\cfttabfont}{表 }

% 中文化各名稱
\renewcommand{\contentsname}{目錄}
\renewcommand{\figurename}{圖}
\renewcommand{\tablename}{表}
\renewcommand{\listfigurename}{圖目錄}
\renewcommand{\listtablename}{表目錄}
\renewcommand{\refname}{參考文獻}

% =============== 圖表格式 =================
% 將圖，表，與公式的編號加上章節編號，並改為 - 分隔符號
\counterwithin{figure}{section}
\renewcommand{\thefigure}{\arabic{section}-\arabic{figure}}
\counterwithin{table}{section}
\renewcommand{\thetable}{\arabic{section}-\arabic{table}}
\counterwithin{equation}{section}
\renewcommand{\theequation}{\arabic{section}-\arabic{equation}}

% Set the default fonts
\setmainfont{Times New Roman}
\setCJKmainfont[AutoFakeBold=true]{標楷體}

\pagestyle{PlainWaterMark}
\@setspacing

\makeatletter
\AtBeginDocument{
  \hypersetup{
    pdftitle={\@titleen},
    pdfauthor={\@author},
  }
}
\makeatother