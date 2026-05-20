\newif\if@songnumber

\DeclareOption{songnumber}{\@songnumbertrue}
\ProcessOptions*    %这部分用于读取给类文件传入的参数

\ProvidesClass{tjuthesis-Bachelor}  %定义类文件名称
\LoadClass[zihao=-4,openany,oneside]{ctexbook}  %以 ctexbook 为基础类，设置默认大小为小四、openany（章节可以从任意页开始）和 oneside（单面打印）

\RequirePackage[a4paper,
            left=3.57cm,right=2.77cm,
            top=2.75cm,bottom=2.54cm,
            footskip=7.9mm,
            headheight=5mm,headsep=7.5mm]{geometry} %页面设置
\RequirePackage{fancyhdr}   %用于设置页眉页脚的宏包
\RequirePackage{titletoc}   %用于设置目录样式的宏包
\RequirePackage{graphicx}   %支持插图处理的宏包
\RequirePackage[percent]{overpic}
\RequirePackage{pdfpages}   %用于插入pdf文件的宏包
\RequirePackage{pifont}     %提供特殊符号的宏包（如 \ding{173} 代表圈1）
\RequirePackage{booktabs}   %用于绘制三线表的横线
\RequirePackage{amsmath}    %基础数学包
\RequirePackage{amsfonts}   %支持公式中使用特殊字体
\RequirePackage[hidelinks]{hyperref}    % 将交叉引用设置为超链接
\RequirePackage{newtxmath}  % 新罗马风格数学公式字体
\RequirePackage[font=small]{caption}    %用于设置图表标题样式的宏包
\RequirePackage{xcolor}     %提供颜色支持的宏包
\RequirePackage{listings}   %用于设置代码块样式的宏包
\RequirePackage[style=gb7714-2015, gbnamefmt=lowercase]{biblatex}    %参考文献管理的宏包，使用GB/T 7714-2015标准

\setmainfont{Times New Roman}   %设置西文字体为新罗马字体
\setmonofont{SimHei}    %设置等宽字体为黑体（依旧邪修大法用来修改标题序号数字字体）

% 覆盖 ctexbook 的默认 CJK 主字体：强制使用 SimSun（学校规范字体），
% 避免在 macOS 下默认走 STSong（华文宋体）触发格式检查报错。
% SimSun 已确认在用户字体目录下。
\setCJKmainfont{SimSun}[AutoFakeBold=2]
\setCJKsansfont{SimHei}[AutoFakeBold=2]

\if@songnumber
    \setsansfont{SimSun} %邪修大法修改参考文件序号为宋体之定义无衬线字体为宋体
    \DeclareFieldFormat{labelnumberwidth}{%
        {\sffamily[\rmfamily #1\sffamily]}%
    } %中括号用宋体（\sffamily 已映射至 SimSun），中括号内的数字用 Times New Roman（\rmfamily）
\fi

% 宋体、黑体伪粗体
\setCJKfamilyfont{son}[AutoFakeBold={2}]{SimSun} 
\renewcommand*{\songti}{\CJKfamily{son}}
\newcommand{\songtibf}{\songti\textbf}  %定义一个新的命令表示宋体加粗
\setCJKfamilyfont{hei}[AutoFakeBold={2}]{SimHei}
\renewcommand*{\heiti}{\CJKfamily{hei}}
\newcommand{\heitibf}{\heiti\textbf}    %定义一个新的命令表示黑体加粗

\fancypagestyle{plain}{ %修改默认页眉页脚样式
    \fancyhf{}  % 清除所有页眉页脚重新设置
    \fancyhead[C]{\songti\zihao{5}\@cheading}   % 页眉，宋体五号
    \fancyfoot[C]{\songti\zihao{-5}\thepage}    % 页脚，宋体小五号，\thepage 代指页码
    \renewcommand{\headrulewidth}{0.5bp}    % 页眉横线粗细
    \renewcommand{\footrulewidth}{0bp}      % 页脚横线粗细
}

\fancypagestyle{noheader}{ %定义一个新的页眉页脚样式 noheader，只有页脚没有页眉
    \fancyhf{}  % 清除所有页眉页脚重新设置
    \fancyfoot[C]{\songti\zihao{-5} \thepage}   % 页脚，宋体小五号，\thepage 代指页码
    \renewcommand{\headrulewidth}{0bp}  % 页眉横线粗细
    \renewcommand{\footrulewidth}{0bp}  % 页脚横线粗细
}

\renewcommand{\frontmatter}{ %改写命令 \frontmatter，使其使用 noheader 样式并设置页码为大写罗马数字
    \@mainmatterfalse
    \clearpage
    \pagestyle{noheader}    % 使用页眉页脚样式 noheader
    \pagenumbering{Roman}   % 大写罗马数字页码（会重置页码）
    \setlength{\baselineskip}{20bp plus 2bp minus 2bp}  % 设置弹性行高为 20±2bp （optional）
} 
\renewcommand{\mainmatter}{ %改写命令 \mainmatter，使其使用 plain 样式并设置页码为阿拉伯数字
    \@mainmattertrue
    \clearpage
    \pagestyle{plain}   % 使用页眉页脚样式 plain 
    \pagenumbering{arabic}  % 使用阿拉伯数字页码（会重置页码）
} 

\ctexset{   %各级标题格式设置
    contentsname={目\quad 录},  % 目录的标题 
    secnumdepth=3,  % 标题编号深度
    chapter={
        format={\centering\zihao{-3}\heiti\ttfamily\CJKfamily{hei}},    % 小三，黑体，居中多出来的是为了解决中英混排的问题）
        number={\chinese{chapter}}, % 章节编号黑体中文数字
        name={第,章},   % 章前后缀
        aftername=\quad, 
        beforeskip=30bp,    % 段前间距 （规定 30~36 bp 之间）
        afterskip=30bp,     % 段后间距 （规定 30~36 bp 之间）
    },
    section={
        format={\zihao{4}\heiti\ttfamily\CJKfamily{hei}},   % 四号黑体（
        numberformat={\zihao{4}\ttfamily},   % 邪修大法之章节编号数字使用黑体
        beforeskip=20bp,    % 段前间距 （规定 18~24 bp 之间）
        afterskip=20bp,     % 段后间距 （规定 18~24 bp 之间）
        aftername=\quad,    % 编号与标题之间空格
    },
    subsection={
        format={\zihao{4}\heiti\ttfamily\CJKfamily{hei}},   % 四号黑体
        numberformat={\zihao{4}\ttfamily}, 
        beforeskip=12bp,    % 段前间距 （规定 12~15 bp 之间）
        afterskip=12bp,     % 段后间距 （规定 12~15 bp 之间）
        aftername=\quad,
    },
    subsubsection={ %单纯为了附录才有这个格式的设置
        format={\zihao{4}\heiti\ttfamily\CJKfamily{hei}},   % 四号黑体
        numberformat={\zihao{4}\ttfamily}, 
        beforeskip=12bp,    % 段前间距 （规定 12~15 bp 之间）
        afterskip=12bp,     % 段后间距 （规定 12~15 bp 之间）
        aftername=\quad,
    }
}

\addtocontents{toc}{\protect\thispagestyle{noheader}}   % 设置目录页的页眉页脚样式为 noheader 
\setcounter{tocdepth}{2}    % 设置 tocdepth 目录深度 （2 = subsection，即三级标题）
\titlecontents{chapter}
    [0em]   % 缩进为 0em = 0 字符
    {\heiti\zihao{-4}\setlength{\baselineskip}{1.2\baselineskip}}   %黑体小四，行距1.2倍（这里是latex的行距）
    {\thecontentslabel\quad}{}
    {\titlerule*[5bp]{$\cdot$}\zihao{-4}\contentspage}
\titlecontents{section}
    [2em]   % 缩进为 2em = 4 字符
    {\zihao{-4}\setlength{\baselineskip}{1.2\baselineskip}}
    {\thecontentslabel\quad}{} %二级及以下层级标题序号为黑体
    {\titlerule*[5bp]{$\cdot$}\zihao{-4}\contentspage}
\titlecontents{subsection}
    [4em]   % 缩进为 4em = 4 字符
    {\zihao{-4}\setlength{\baselineskip}{1.2\baselineskip}}
    {\thecontentslabel\quad}{}
    {\titlerule*[5bp]{$\cdot$}\zihao{-4}\contentspage}

%为什么这里会有一段多出来的代码呢，当然是因为学校的word模板太难绷了，如果你使用早些时候的模板并且没有更新过目录，那么目录的二级及以下标题的西文字符使用的都是新罗马字体，但是如果你更新了目录，他就给你变成了黑体，但是此时页码却还是新罗马，到底闹哪样？总之按照其更新前的格式排版已经通过了格式检测系统，上面默认的代码就是那个，要是想用难绷的黑体，下面的代码我也搓出来了。。。
% \titlecontents{chapter}
%     [0em]   % 缩进为 0em = 0 字符
%     {\heiti\zihao{-4}\setlength{\baselineskip}{1.2\baselineskip}}   %黑体小四，行距1.2倍（这里是latex的行距）
%     {\thecontentslabel\quad}{}
%     {\titlerule*[5bp]{$\cdot$}\zihao{-4}\contentspage}
% \titlecontents{section}
%     [2em]   % 缩进为 2em = 4 字符
%     {\zihao{-4}\setlength{\baselineskip}{1.2\baselineskip}}
%     {\ttfamily\thecontentslabel\quad}{} %二级及以下层级标题序号为黑体
%     {\titlerule*[5bp]{$\cdot$}\zihao{-4}\contentspage}
% \titlecontents{subsection}
%     [4em]   % 缩进为 4em = 4 字符
%     {\zihao{-4}\setlength{\baselineskip}{1.2\baselineskip}}
%     {\ttfamily\thecontentslabel\quad}{}
%     {\titlerule*[5bp]{$\cdot$}\zihao{-4}\contentspage}

\renewcommand{\tablename}{表}                                     % 插表题头
\renewcommand{\figurename}{图}                                    % 插图题头
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}       % 使图编号为 7-1 的格式 %\protect{~}
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}         % 使表编号为 7-1 的格式
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}   % 使公式编号为 7-1 的格式

\captionsetup[table]{labelsep=quad} %表注修改为全角空格
\captionsetup[figure]{labelsep=quad} %图注修改为全角空格

\graphicspath{{figures/}}   % 定义所有的图像文件在 figures 子目录下

\newcommand{\figuremacro}[5]{ %图片插入宏
  \begin{figure}[#1] %第一个参数是浮动体样式设置
    \centering
    \includegraphics[width=#4\textwidth]{#2}   %第2个参数是图片文件路径，第4个参数是图片占文本宽度的比例
    \caption{#3} %第三个参数是图片标题
    \label{#5} %第五个参数是图片标签
  \end{figure}
}

\newcommand{\tablemacro}[6]{ %表格插入宏
    \begin{table}[#1] %第一个参数是浮动体样式设置
    \centering
    \caption{#2}\zihao{5} %第二个参数是表格标题
    \begin{tabular}{#3}
        \toprule
        #4 %第三个参数是表格列标题，需要手动使用\songtibf加粗
        \midrule
        #5 %第四个参数是表格内容
        \bottomrule
    \end{tabular}
    \label{#6} %第五个参数是表格标签
\end{table}
}

% \newcommand{\tablemacrofw}[6]{ %页面全宽表格插入宏
%     \begin{table}[#1] %第一个参数是浮动体样式设置
%     \centering
%     \caption{#2}\zihao{5} %第二个参数是表格标题
%     \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}#3}
%         \toprule
%         #4 %第三个参数是表格列标题，需要手动使用\songtibf加粗
%         \midrule
%         #5 %第四个参数是表格内容
%         \bottomrule
%     \end{tabular*}
%     \label{#6} %第五个参数是表格标签
% \end{table}
% }


\addbibresource{reference.bib} %添加参考文献数据库文件

\lstset{ %一个简单的代码高亮样式设置
    basicstyle=\ttfamily\small,
    numbers=left,
    numberstyle=\scriptsize,
    stepnumber=1,
    numbersep=8pt,
    frame=single,
    framerule=0.5pt,
    breaklines=true,
    breakatwhitespace=false,
    tabsize=4,
    showstringspaces=false,
    showspaces=false,
    showtabs=false,
    columns=flexible,
    keepspaces=true,
    keywordstyle=\color{blue},
    commentstyle=\color{green!50!black},
    stringstyle=\color{red!60!black},
    backgroundcolor=\color{white},
    captionpos=b
}

\newlength{\@info@width} %创建变量用于设置封面页信息栏横线长度
\setlength{\@info@width}{8cm} % 默认值为8cm
\newcommand{\infowidth}[1]{\setlength{\@info@width}{#1}} %定义新命令以便全局调用

\newcommand{\ctitle}[1]{\gdef\@ctitle{#1}}\def\@ctitle{} %定义文章标题命令
\newcommand{\caffil}[1]{\gdef\@caffil{#1}}\def\@caffil{} %定义学院名称命令
\newcommand{\csubject}[1]{\gdef\@csubject{#1}}\def\@csubject{} %定义专业名称命令
\newcommand{\cgrade}[1]{\gdef\@cgrade{#1}}\def\@cgrade{} %定义年级命令
\newcommand{\cauthor}[1]{\gdef\@cauthor{#1}}\def\@cauthor{} %定义作者姓名命令
\newcommand{\cnumber}[1]{\gdef\@cnumber{#1}}\def\@cnumber{} %定义学号命令
\newcommand{\csupervisor}[1]{\gdef\@csupervisor{#1}}\def\@csupervisor{} %定义指导教师命令
\newcommand{\cheading}[1]{\gdef\@cheading{#1}}\def\@cheading{} %定义页眉标题命令

\newcommand{\cabstractcn}[1]{\gdef\@cabstractcn{#1}}\def\@cabstractcn{} %定义中文摘要命令
\newcommand{\cabstracten}[1]{\gdef\@cabstracten{#1}}\def\@cabstracten{} %定义英文摘要命令
\newcommand{\ckeywordcn}[1]{\gdef\@ckeywordcn{#1}}\def\@ckeywordcn{} %定义中文关键词命令
\newcommand{\ckeyworden}[1]{\gdef\@ckeyworden{#1}}\def\@ckeyworden{} %定义英文关键词命令

\newcommand{\makecover}{ %生成封面页
    \begin{titlepage}
        \thispagestyle{empty} %封面页无页眉页脚
        \centering
        \includegraphics[width=0.4\textwidth]{tjuname.eps} %插入天津大学校名
        
        \vspace{21pt}
        \zihao{2}{\heitibf{本科生毕业论文}}
        \vfill %动态填充空隙
        \includegraphics[width=0.4\textwidth]{tjulogo.eps} %插入天津大学校徽

        \vspace{20pt}
        {\zihao{-3}\heitibf{题目：\@ctitle}}

        \vspace{30pt}
        \renewcommand{\arraystretch}{1.5} %设置表格行高1.5倍
        {\zihao{3}\songtibf{
            \begin{tabular}{lc} 
                学\qquad 院 &  \underline{\makebox[\@info@width][c]{\@caffil}}     \\
                专\qquad 业 &  \underline{\makebox[\@info@width][c]{\@csubject}}   \\
                年\qquad 级 &  \underline{\makebox[\@info@width][c]{\@cgrade}}     \\
                姓\qquad 名 &  \underline{\makebox[\@info@width][c]{\@cauthor}}    \\
                学\qquad 号 &  \underline{\makebox[\@info@width][c]{\@cnumber}}    \\
                指导教师 &  \underline{\makebox[\@info@width][c]{\@csupervisor}}   \\
            \end{tabular}
            }
        }
        \vspace{1cm}
    \end{titlepage}
}

\newcommand{\makeabstract}{ %生成摘要页
    % 中文摘要页
    \chapter*{\normalfont\zihao{2}\textbf{\songti 摘 \qquad 要}}    %\normalfont与下方作用类似
    \thispagestyle{noheader}
    \@cabstractcn

    \bigskip % 空一行

    \noindent {\songti\zihao{4}\textbf{关键词：}} 
    \@ckeywordcn

    % 英文摘要页
    \chapter*{\normalfont\zihao{2}\textbf{ABSTRACT}}    %摘要使用的是无编号章节标题格式，但是需要使用新罗马字体故手动改回
    \thispagestyle{noheader}
    \@cabstracten

    \bigskip 

    \noindent {\zihao{4}\textbf{KEY WORDS:} }
    \@ckeyworden
}

\newenvironment{appendixenv}{ %附录环境，重置章节编号并修改编号格式
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \setcounter{figure}{0}
    \setcounter{table}{0}
    \setcounter{equation}{0}
    \setcounter{lstlisting}{0}
    \def\thesection{\songti\bfseries 附录\Alph{section}}
    \def\thesubsection{\Alph{section}.\arabic{subsection}}
    \def\thesubsubsection{\Alph{section}.\arabic{subsection}.\arabic{subsubsection}}
    \def\thefigure{\Alph{section}\ifnum\value{figure}<10 0\fi\arabic{figure}}
    \def\thetable{\Alph{section}-\arabic{table}}
    \def\theequation{\Alph{section}-\arabic{equation}}
    \def\thelstlisting{\Alph{section}-\arabic{lstlisting}}
    \@addtoreset{figure}{section}
    \@addtoreset{table}{section}
    \@addtoreset{equation}{section}
    \@addtoreset{lstlisting}{section}
    % 附录内的各级标题改用宋体加粗（符合学校规范，不再沿用正文章节的黑体）
    \ctexset{
        section/format={\zihao{4}\songti\bfseries},
        section/numberformat={\zihao{4}\songti\bfseries},
        subsection/format={\zihao{4}\songti\bfseries},
        subsection/numberformat={\zihao{4}\songti\bfseries},
        subsubsection/format={\zihao{4}\songti\bfseries},
        subsubsection/numberformat={\zihao{4}\songti\bfseries}
    }
}{}

