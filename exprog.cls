\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{exprog}[2000/01/04 v0.1 ^^J
  \space
  Presentation des exercices de programmation.]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            O P T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifexprogTwelvePoints
\exprogTwelvePointsfalse
\DeclareOption{12pt}{%
  \exprogTwelvePointstrue
  \PassOptionsToClass{\CurrentOption}{article}%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions
\LoadClass{article}

\RequirePackage{a4}
\addtolength{\textwidth}{2cm}
\addtolength{\oddsidemargin}{-1cm}
\ifexprogTwelvePoints
  \addtolength{\textheight}{2cm}
\else
  \addtolength{\textheight}{1cm}
\fi
\setlength{\parindent}{0pt}

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\definecolor{umons-red}{cmyk}{0., 1., 0.6, 0.2}
\definecolor{umons-gray}{cmyk}{0, 0, 0, 0.5}
\definecolor{umons-turquoise}{cmyk}{0.9, 0., 0.2, 0.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Translations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xspace,translator}

% \providetranslation[to=french]{Question}{Question}
\providetranslation[to=french]{True}{Vrai}
\providetranslation[to=french]{False}{Faux}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                               P D F
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Recently \pdfinfo became defined even with "latex".
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{%
    \hypersetup{
      pdftitle={\exprog@title@pdfinfo},
      pdfauthor={Troestler Christophe},
      pdfkeywords={numerical analysis},
      pdfsubject={\exprog@course@pdfinfo},
      pdfpagemode={UseNone},
      colorlinks=true,
      urlcolor=umons-turquoise,
      citecolor=umons-turquoise,
      linkcolor=umons-red,
    }}{%
    \message{exprog: package "hyperref" not loaded.}%
  }%
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              Perfection
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\overfullrule=10pt


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            F O N T S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Math \big

\DeclareFontShape{OMX}{cmex}{m}{n}{
  <-8> cmex7
  <8> cmex8
  <9> cmex9
  <10> <10.95> <12> <14.4> <17.28> <20.74> <24.88> cmex10
}{}%


\def\Delimiter@Enlarge@to@factor#1#2{% <enlargment> <delimiter to enlarge>
  {\def\Delimiter@Enlarge@to@factor@choice##1##2{% <style> <delimiter>
    %%% \box0 shall contain the delimiter at normal size:
    \setbox\z@=\hbox{$\m@th ##1{##2}$}%
    \vcenter{\hbox{$##1\left #2\vbox to#1\ht\z@{}\right.\n@space$}}}% write it!
  %%% \mathpalette <command> <second arg of the command>
  \mathpalette \Delimiter@Enlarge@to@factor@choice (}}


\AtBeginDocument{% => override any other package (amsmath,...)
\ifx\@ptsize\undefined
  %%% Maybe, using "slides" (SliTeX) class
  \typeout{Warning: \string\big, \string\Big, \bigg, \string\Bigg\space
    are NOT re-defined and may be incorrect.}
\else
\ifcase \@ptsize
  %%% 10pt ----------
  \def\big#1{\Delimiter@Enlarge@to@factor{1.1333333}{#1}}  % 8.5pt
  \def\Big#1{\Delimiter@Enlarge@to@factor{1.5333333}{#1}}  % 11.5 pt
  \def\bigg#1{\Delimiter@Enlarge@to@factor{1.9333333}{#1}} % 14.5 pt
  \def\Bigg#1{\Delimiter@Enlarge@to@factor{2.3333333}{#1}} % 17.5 pt
\or % 11pt ----------
  \def\big#1{\Delimiter@Enlarge@to@factor{1.1385084}{#1}}  % 9.35 pt
  \def\Big#1{\Delimiter@Enlarge@to@factor{1.5403349}{#1}}  % 12.65 pt
  \def\bigg#1{\Delimiter@Enlarge@to@factor{1.9421613}{#1}} % 15.95 pt
  \def\Bigg#1{\Delimiter@Enlarge@to@factor{2.3439878}{#1}} % 19.25 pt
\or % 12pt ----------
  \def\big#1{\Delimiter@Enlarge@to@factor{1.1111111}{#1}}  % 10 pt
  \def\Big#1{\Delimiter@Enlarge@to@factor{1.5333333}{#1}}  % 13.8 pt
  \def\bigg#1{\Delimiter@Enlarge@to@factor{1.9333333}{#1}} % 17.4 pt
  \def\Bigg#1{\Delimiter@Enlarge@to@factor{2.3333333}{#1}} % 21 pt
\fi % end of \ifcase\@ptsize
\fi % end of \ifx\@ptsize\undefined
}



%% Special Definitions
%%----------------------------------------------------------------------
\newcommand\exprog@titlefont{\fontfamily{phv}\fontseries{m}\fontshape{n}%
  \fontsize{23}{25}\selectfont}
\newcommand\exprog@coursefont{\fontfamily{phv}\fontseries{m}\fontshape{n}%
  \fontsize{10}{14}\selectfont}
\newcommand\exprog@notesfont{\fontfamily{phv}\fontseries{m}\fontshape{n}%
  \fontsize{10}{12}\selectfont}
\newcommand\exprog@smalltitlefont{\fontfamily{phv}\fontseries{m}\fontshape{n}%
  \fontsize{14}{16}\selectfont}
\newcommand\exprog@smallcoursefont{\fontfamily{phv}\fontseries{m}\fontshape{n}%
  \fontsize{10}{12}\selectfont}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              First page
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\exprog@course{Introduction \`a l'Analyse Num\'erique}
\def\exprog@course@pdfinfo{Introduction a l'Analyse Numerique}
\newcommand{\course}{\@ifnextchar[{\exprog@course@ii}{\exprog@course@i}}
\newcommand\exprog@course@i[1]{\exprog@course@ii[{#1}]{#1}}
\def\exprog@course@ii[#1]#2{%
  \gdef\exprog@course@pdfinfo{#1}%
  \gdef\exprog@course{#2}%
}

\def\exprog@notes{}
\newcommand{\notes}[1]{\gdef\exprog@notes{#1}}

\newcommand\exprog@title{}
\newcommand\exprog@title@pdfinfo{}
\renewcommand{\title}[2][\jobname]{%
  \gdef\exprog@title@pdfinfo{#1}%
  \gdef\exprog@title{#2}}%
\AtBeginDocument{%
  \renewcommand{\title}[1]{\gdef\exprog@title{#1}}%
}


\AtEndDocument{%
  \null % if (by mistake?) a new page was started => label well
        % defined...
  \def\@currentlabel{total pages}%
  \label{exprog:totalpages}%
}
\AtBeginDocument{%
  \@ifundefined{hypersetup}{%
    \newcommand{\thetotalpage}{\pageref{exprog:totalpages}}
  }{%
    % hyperref package loaded => no link
    \newcommand{\thetotalpage}{\pageref*{exprog:totalpages}}
  }}

\newcommand{\exprog@firstpage@set@oddhead}{%
  \renewcommand{\@oddhead}{%
    \smash{\vtop to \textheight{%
        %\vspace*{-1in}
        \vspace*{\voffset}\vspace*{-1in}\vspace*{-\topmargin}%
        \noindent
        \hspace*{-\hoffset}\hspace*{-1in}\hspace*{-\oddsidemargin}%
        \hspace*{5mm}% visual
        \includegraphics[width=0.22\paperwidth]{UMONS}
        \vss}}}}

\newcommand\ps@firstpage{%
  \renewcommand\@mkboth[2]{}%
  \IfFileExists{UMONS.pdf}{\exprog@firstpage@set@oddhead}{%
    \IfFileExists{UMONS.png}{\exprog@firstpage@set@oddhead}{}}%
  \renewcommand\@oddfoot{\reset@font \hfil \thepage/\thetotalpage}%
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot}


\newlength{\exprog@titleskip}    \setlength{\exprog@titleskip}{6pt}
\newlength{\exprog@rulethickness}\setlength{\exprog@rulethickness}{0.5pt}
\newcommand{\exprog@beforetext}{3ex}

\renewcommand{\maketitle}{{%
  \newpage
  \vspace*{-15mm}%
  \thispagestyle{firstpage}%
  \begin{center}
    \exprog@coursefont \exprog@course

    \exprog@titlefont  \exprog@title
    \ifx \@author\empty \else
      \par\vspace*{6pt}
      \exprog@coursefont \@author
    \fi
  \end{center}
  \ifx\exprog@notes\empty \vspace*{-2ex}\else {
    \exprog@notesfont  \exprog@notes
    \par}\fi
  \vspace*{6pt}\hrule height 2\exprog@rulethickness
  \par\vspace*{\exprog@beforetext}}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                        O T H E R    P A G E S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand{\ps@exprog}{%
  \let\@mkboth\@gobbletwo
  \renewcommand{\@oddhead}{{%
      \vbox to 0pt{\vss
        \noindent
        \exprog@smalltitlefont    \exprog@title
        \par
        \vspace*{3pt}
        \exprog@smallcoursefont\strut   \exprog@course
        \par\hrule height 2\exprog@rulethickness width\hsize
      }%
    }}%
  \renewcommand{\@oddfoot}{\reset@font \hfil \thepage/\thetotalpage}%
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot}

\pagestyle{exprog}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                           A B S T R A C T
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewenvironment{abstract}{%
  \vspace*{-\exprog@beforetext}\vspace*{6pt}%
  \begin{quote}
    \renewcommand{\itemizesep}{1mm}%
    \small
    }{%
  \end{quote}
  \vspace*{6pt}  \hrule height 1pt
  \vspace*{\exprog@beforetext}%
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                          Q U E S T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{exprog@question}
\setcounter{exprog@question}{0}

\newcommand{\questionstyle}[1]{%
  \textsf{#1}}

\newcommand{\questionname}{\translate{Question}}

\newenvironment{question}[1][]{%
  \refstepcounter{exprog@question}%
  {\parskip=0pt \par}\vspace{1ex}%
  \noindent\questionstyle{\questionname~\arabic{exprog@question}#1.}\quad
  \ignorespaces
}{%
  {\parskip=0pt \par}\vspace{1ex}%
}


\newenvironment{question*}{%
  \gdef\@currentlabel{\the\c@exprog@question}%
  {\parskip=0pt \par}\vspace{1ex}%
  \noindent\textsf{\questionname~\arabic{exprog@question} (suite).}\quad
  \ignorespaces
}{%
  {\parskip=0pt \par}\vspace{4ex}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                         M I S C.   T O O L S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% We need to redefine \begin{document} because we want to set this after
%% possibly loading babel
\let\exprog@document=\document
\def\document{\exprog@document
  \renewcommand\labelitemi{{\vrule depth 0pt width  .8ex height .8ex}}%
  \newcommand\itemizesep{2mm}%

  \renewenvironment{itemize}{%
    \ifnum\@itemdepth >\thr@@ \@toodeep   \else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter\list \csname\@itemitem\endcsname {%
      \setlength{\topsep}{0.3ex}%
      \setlength{\itemsep}{0pt}%
      \setlength{\leftmargin}{2.3ex}%
      \def\makelabel####1{\hss \llap{####1}}}%
    \fi
  }{%
    \global\advance\@listdepth\m@ne \endtrivlist
  }
}

\newenvironment{itemizetext}{%
  \ifnum\@itemdepth >\thr@@ \@toodeep   \else
  \advance\@itemdepth\@ne
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \expandafter\list \csname\@itemitem\endcsname {%
    \setlength{\topsep}{0.3ex}%
    \setlength{\itemsep}{0pt}%
    \setlength{\leftmargin}{0pt}%
    \setlength{\itemindent}{2.3ex}%
    \def\makelabel##1{\hss \llap{##1}}}%
  \fi
}{%
  \global\advance\@listdepth\m@ne \endtrivlist
}


%% enumerate
%%----------------------------------------------------------------------
\renewcommand\labelenumi{(\theenumi)}
\renewcommand\theenumi{\alph{enumi}}
\renewcommand\labelenumii{(\theenumii)}
\renewcommand\theenumii{\arabic{enumii}}

\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >\thr@@ \@toodeep
  \else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter\list \csname label\@enumctr \endcsname {%
      \usecounter\@enumctr
      \ifdim\parindent<1.8em \leftmargin=2em \else \leftmargin=\parindent \fi
      \def\makelabel##1{\hss\llap{\textsf{##1}}}%
    }%
    \fi
  }{%
    \global\advance\@listdepth\m@ne
    \endtrivlist
  }


%% True/False questions
%%----------------------------------------------------------------------

\newcommand{\exprogTrueLabel}{\translate{True}\xspace :}
\newcommand{\exprogFalseLabel}{\translate{False}\xspace :}

\newcommand{\exprog@TF@drawbox}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.7ex depth 0.3ex\hskip 2ex}}%
      \hrule}\vrule}}

\AtBeginDocument{% Choose the symbol for the tick
  \ifx\ding\@undefined
    \ifx\checkmark\@undefined
    \newcommand{\exprogtick}{$\times$}%
    \else
    \newcommand{\exprogtick}{$\checkmark$}%
    \fi
  \else
    \newcommand{\exprogtick}{\ding{51}}%
  \fi}

\newcommand{\exprog@TF@tickedbox}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.7ex depth 0.3ex
          \hbox to 2ex{\hss \exprogtick \hss}}}%
      \hrule}\vrule}}

\newcommand{\exprog@TF@drawbox@large}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.8ex depth 0.5ex\hskip 2.2ex}}%
      \hrule}\vrule}}

\newcommand{\exprog@TF@drawbox@large@ticked}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.8ex depth 0.5ex
          \hbox to 2.2ex{\hss \exprogtick \hss}}}%
      \hrule}\vrule}}

\newcounter{TrueFalse}

\def\exprog@TF@number{\hbox to 1.8em{\textsf{(\theTrueFalse)}\hss}}

% For corrections: allow to put a tick

\let\exprog@TF@item@orig=\item
\newif\ifexprog@TF@item@thickT
\newif\ifexprog@TF@item@thickF

\define@key{exprog@TF}{true}[true]{\csname exprog@TF@item@thickT#1\endcsname}
\define@key{exprog@TF}{false}[true]{\csname exprog@TF@item@thickF#1\endcsname}

\newcommand{\exprog@TF@item}[1][]{%
  % Optional arguments "true" and "false" to tick the box.
  \exprog@TF@item@thickTfalse
  \exprog@TF@item@thickFfalse
  \setkeys{exprog@TF}{#1}%
  \exprog@TF@item@orig}

% Label "True □ False □", with boxes to tick.
% Optional argument "true" and "false" to tick tha appropriate box.
\newenvironment{TrueFalse}{\bgroup
  \def\exprog@TF@label{\exprog@TF@number
    \exprogTrueLabel\
    \ifexprog@TF@item@thickT \exprog@TF@tickedbox
    \else \exprog@TF@drawbox\fi\quad
    \exprogFalseLabel\
    \ifexprog@TF@item@thickF \exprog@TF@tickedbox \else \exprog@TF@drawbox\fi}%
  \let\item\exprog@TF@item % locally
  \begin{exprog@TF@gen}
  }{%
  \end{exprog@TF@gen}
  \egroup}

% Boxes to tick (no "True"/"False").
% Optional argument "true" to tick the box.
\newenvironment{TrueFalse*}[1][]{\bgroup
  \def\exprog@TF@label{\exprog@TF@number
    \ifexprog@TF@item@thickT \exprog@TF@drawbox@large@ticked
    \else \exprog@TF@drawbox@large\fi}%
  \let\item\exprog@TF@item % locally
  \begin{exprog@TF@gen}
  }{%
  \end{exprog@TF@gen}
  \egroup}

\newenvironment{exprog@TF@gen}{%
  \bgroup
  \ifnum \@enumdepth >\thr@@ \@toodeep  \else
    \advance \@enumdepth \@ne
    \setcounter{TrueFalse}{0}%
    \ifnum \@enumdepth > \@ne
      \def\theTrueFalse{\@roman \c@TrueFalse}%
    \else \def\theTrueFalse{\@alph \c@TrueFalse}\fi
    \expandafter\list{%
      \addtocounter{TrueFalse}{1}%
      \gdef\@currentlabel{\theTrueFalse}%
      \exprog@TF@label
    }{%
      \settowidth{\labelwidth}{\exprog@TF@label}
      \addtolength{\labelwidth}{6pt}
      \settowidth{\leftmargin}{\exprog@TF@number}
      \addtolength{\leftmargin}{6pt}% same as for \labelwidth
      \setlength{\labelsep}{1em}
      \setlength{\itemindent}{\labelwidth}
      \addtolength{\itemindent}{\labelsep}
      \addtolength{\itemindent}{-\leftmargin}
      \setlength{\topsep}{0.8ex plus 0.5ex minus 0.5ex}
      \setlength{\itemsep}{0.6ex plus 0.2ex minus 0.2ex}
      \def\makelabel##1{\hss \llap{##1}}%
    }%
    \fi
}{%
  \global\advance\@listdepth\m@ne \endtrivlist
  \egroup
}


\newenvironment{choices}[1][]{%
  \bgroup
  \def\exprog@TF@label{#1\exprog@TF@drawbox@large}%
  \begin{exprog@TF@gen}
  }{%
  \end{exprog@TF@gen}
  \egroup}


\endinput
