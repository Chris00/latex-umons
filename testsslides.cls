\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{testsslides}[2000/01/04 v0.1 ^^J
  \space
  Transparents pour les corrections des tests de Mathematique elementaire.]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            O P T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{slides}}

\ProcessOptions
\LoadClass{slides}


%\RequirePackage[T1]{fontenc}
\RequirePackage[francais]{babel}
%\RequirePackage{times}
%\usepackage{mathptmx}
%\RequirePackage{euler}
%\usepackage{palatino}

\RequirePackage{landscape}
\special{landscape}
\setlength{\@tempdima}{\paperwidth}
\setlength{\paperwidth}{\paperheight}
\setlength{\paperheight}{\@tempdima}

%% PDF output
%%----------------------------------------------------------------------

\@ifundefined{pdfoutput}{}{%
  \pdfpagewidth=\paperwidth
  \pdfpageheight=\paperheight
  %%
  \RequirePackage{color}
  \definecolor{slide@green}{rgb}{0.56862745,0.78039216,0.63137255}% #91c7a1
  \definecolor{slide@darkgreen}{rgb}{0.4,0.47,0.42}% #667a6a
  \definecolor{slide@blue}{rgb}{0.23,0.85,0.98}% #3ad9fc
  \definecolor{slide@darkblue}{rgb}{0.23,0.33,0.95}
  \definecolor{slide@metalblue}{rgb}{0.21,0.67,0.61}
  \definecolor{slide@red}{rgb}{0.67,0.03,0.06}
  %%
%   \RequirePackage[%
%   colorlinks=true,
%   urlcolor=slide@darkgreen,
%   citecolor=slide@darkblue,
%   linkcolor=slide@red,
%   pdffitwindow=true, 
%   pdfpagemode=None
%   ]{hyperref}
  %%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                         D I M E N S I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\overfullrule=10pt
\errorcontextlines=5

\AtBeginDocument{%
  \parskip=10pt plus 6pt minus 6pt
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            F O N T S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{
\DeclareFontShape{OMX}{cmex}{m}{n}{
%   <-8> [5] cmex7
%   <8>  [5] cmex8
%   <9>  [5] cmex9
%   <10> <10.95> <12> <14.4> <17.28> <20.74> <24.88> [5] cmex10
  <-> [4] cmex10
}{}%
}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                        P A G E S   S T Y L E
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\test@number{}
\newcommand\testnumber[1]{\gdef\test@number{#1}}

\def\test@date{\today}
\newcommand\testdate[1]{\gdef\test@date{#1}}

\newcommand\test@thetest{%
  \hb@xt@ 3em{\theslide/\thetotalslides \quad
    \rlap{\ifx\test@number\empty \else (test~\test@number)\ \fi}\hss}%
}
\newcommand\testtype[1]{%
  \def\testsslides@temp{#1}%
  \ifx\testsslides@temp \empty
    \gdef\test@thetest{\theslide/\thetotalslides \hspace{-3em}}%
  \else
    \gdef\test@thetest{\theslide/\thetotalslides \quad (#1)\hspace{-3em}}%
  \fi}
\newcommand\exam{\testtype{Examen du~\test@date}}
\newcommand\cote{\testtype{Cot{\'e} du~\test@date}}


\AtEndDocument{%
  \edef\@currentlabel{\arabic{slide}}%
  %% We have to go that funny way because `slide' does not allow
  %% \label to work if we don't open a new page (\null) which we
  %% do not want.
  \immediate\write\@auxout{\string
    \newlabel{test:totalslides}{{\@currentlabel}{\thepage}}}
  %\null\label{test:totalslides}%
  }

\@ifundefined{hypersetup}{%
  \newcommand\thetotalslides{\ref{test:totalslides}}
}{% hyperref
  \newcommand\thetotalslides{\ref*{test:totalslides}}
}


\renewcommand\ps@slide{%
  \def\@oddfoot{\@mainsize \hbox{}\hfil  \test@thetest}%
  \def\@oddhead{}%
  \def\@evenfoot{\@mainsize \hbox{}\hfil\hb@xt@3em{\theslide\hss}}%
  \def\@evenhead{}}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                         S E C T I O N S,...
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand\section[1]{%
  \par\noindent
  {\Large \textbf{#1}}%
  \vspace*{3pt}\hrule height 0.5pt depth 1.5pt
  }

\newcounter{example}
\setcounter{example}{0}

\newcommand\Example{\@ifnextchar[{\Example@i}{\Example@ii}}
\def\Example@i[#1]{%
  \addtocounter{example}{1}%
  \noindent
  \textbf{Exemple~\arabic{example}}~:~\textit{#1}%
  {\parskip=5mm \par}%
  \ignorespaces}
\def\Example@ii{%
  \addtocounter{example}{1}%
  \noindent
  \textbf{Exemple~\arabic{example}}~:~\ignorespaces}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                          Q U E S T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{question}
\setcounter{question}{0}

\newenvironment{question}{%
  \addtocounter{question}{1}%
  \global\edef\@currentlabel{\arabic{question}}%
  \noindent \textbf{Question~\arabic{question}.}\quad
  \itshape
  \ignorespaces
  }{%
  \vspace{1ex plus 0.5ex minus 0.5ex}%
  }


%% Questions split between several pages
\newenvironment{question*}{%
  \noindent \textbf{Question~\arabic{question} (suite).}\quad
  \itshape
  \ignorespaces
  }{%
  \vspace{1ex plus 0.5ex minus 0.5ex}%
  }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                          E N U M E R A T E
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\labelenumi{(\theenumi)}

\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >\thr@@ \@toodeep 
  \else 
    \advance\@enumdepth\@ne 
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter\list \csname label\@enumctr \endcsname {%
      \usecounter\@enumctr 
      \def\makelabel##1{\hss\llap{##1}}%
      \setlength{\parskip}{10pt plus 3pt minus5pt}%
      }%
  \fi}{%
  \global\advance\@listdepth\m@ne 
  \endtrivlist 
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            I T E M I Z E
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{
  \renewcommand\labelitemi{{\vrule depth 0pt width .8ex height .8ex}}
  \newcommand\itemizesep{2mm}

  \renewenvironment{itemize}{\bgroup
    \bbl@nonfrenchlistspacing % babel French redef \trivlist, undo it.
    \ifnum\@itemdepth >\thr@@ \@toodeep   \else 
      \advance\@itemdepth\@ne  
      \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
      \expandafter\list \csname\@itemitem\endcsname 
        {\setlength{\topsep}{0pt}%
          \setlength{\itemsep}{\itemizesep}%
          \setlength{\leftmargin}{2.3ex}%
          \def\makelabel##1{\hss \llap{##1}}}%
    \fi
    }{%
    \global\advance\@listdepth\m@ne \endtrivlist
    \egroup}
}




\endinput