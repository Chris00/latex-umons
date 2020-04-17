\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{tests}[2000/01/04 v0.1 ^^J
  \space
  Format pour des tests et examens.]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            O P T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\iftest@want@rulers \test@want@rulersfalse
\DeclareOption{rulers}{\test@want@rulerstrue}

\newif\iftest@correction \test@correctionfalse
\DeclareOption{correction}{\test@correctiontrue}

\newif\iftest@logo \test@logofalse
\DeclareOption{umons}{\test@logotrue}% (deprecated)
\DeclareOption{logo}{\test@logotrue}% No name, UMONS logo

\newif\iftest@mps \test@mpsfalse
\DeclareOption{mps}{\test@mpstrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions
\LoadClass{article}

%\RequirePackage{a4}
\RequirePackage{graphicx}
\RequirePackage{keyval}
\RequirePackage{geometry}
\geometry{left=18mm, right=22mm, top=40mm, bottom=20mm}
\setlength{\parindent}{0pt}
\RequirePackage{ltxcmds}
\RequirePackage{verbatim}% for the "comment" environment
\RequirePackage{atveryend}
\RequirePackage{xspace,translator}
\RequirePackage{ifthen}

\providetranslation[to=english]{Test no}{Test \#}

\providetranslation[to=french]{Name}{Nom}
\providetranslation[to=french]{Firstname}{Pr\'enom}
\providetranslation[to=french]{Test}{Test}
\providetranslation[to=french]{Exam}{Examen}
\providetranslation[to=french]{Rated exercise}{Coté}
\providetranslation[to=french]{Test no}{Test n$^\circ$}
% \providetranslation[to=french]{Section}{Section}
\providetranslation[to=french]{True}{Vrai}
\providetranslation[to=french]{False}{Faux}
% \providetranslation[to=french]{Question}{Question}
\providetranslation[to=french]{sequel}{suite}

\iftest@want@rulers
\RequirePackage{color}
\fi
\iftest@correction
\RequirePackage{color}
\setlength{\parskip}{3pt plus 5pt minus 1pt}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              Perfection
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\overfullrule}{10pt}



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

\@ifundefined{DeclareUnicodeCharacter}{}{%
  \newcommand{\test@IN}{{\mathbb{N}}}
  \DeclareUnicodeCharacter{2125}{\test@IN}% ℕ
  \newcommand{\test@IZ}{{\mathbb{Z}}}
  \DeclareUnicodeCharacter{2124}{\test@IZ}% ℤ
  \newcommand{\test@IQ}{{\mathbb{Q}}}
  \DeclareUnicodeCharacter{211A}{\test@IQ}% ℚ
  \newcommand{\test@IR}{{\mathbb{R}}}
  \DeclareUnicodeCharacter{211D}{\test@IR}% ℝ
  \newcommand{\test@IC}{{\mathbb{C}}}
  \DeclareUnicodeCharacter{2102}{\test@IC}% ℂ
}


%% Special Definitions
%%----------------------------------------------------------------------
\newcommand{\test@sf}{\fontfamily{phv}\fontseries{m}\fontshape{n}}
\newcommand\test@titlefont{\test@sf      \fontsize{23}{25}\selectfont
  \def\normalsize{\@setfontsize\normalsize\@xiipt{14}}%
}
\newcommand\test@numberfont{\test@sf     \fontsize{17.28}{19}\selectfont}
\newcommand\test@smalltitlefont{\test@sf \fontsize{14}{16}\selectfont
  \def\normalsize{\@setfontsize\normalsize\@xivpt{16}}%
}
\newcommand\test@namesfont{\test@sf      \fontsize{12}{14}\selectfont}
\newcommand\test@smallnamesfont{\test@sf \fontsize{9}{14}\selectfont}

\newcommand\test@correction{\test@sf \color[gray]{0.6}%
  \bfseries\fontsize{30}{32}\selectfont}
\newcommand\test@smallcorrection{\test@sf \color[gray]{0.6}%
  \bfseries\fontsize{20}{20}\selectfont}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                             Graphics
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Add .mps as favorite to the graphics extensions:
\iftest@mps
\AtBeginDocument{%
  \DeclareGraphicsExtensions{.mps,\Gin@extensions}%
}
\fi


\def\test@logo@file{UMONS+txt}
\newcommand{\settestlogo}[1]{\def\test@logo@file{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              First page
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test number and date.
%% (We hold the changes in some variables, allowing redefining them
%% and then activating the changes with \maketitle -- that allows
%% several tests to be grouped in a single file.)
\newcommand\test@number@change{0}
\newcommand{\testnumber}[1]{\gdef\test@number@change{#1}}
\newcommand\test@date@change{\today}
\newcommand\test@datepdf@change{\test@date}
\newcommand{\testdate}{\@ifnextchar[%]
  {\testdate@pdf}{\testdate@std}}
\def\testdate@pdf[#1]#2{%
  \gdef\test@datepdf@change{#1}%
  \gdef\test@date@change{#2}}
\newcommand\testdate@std[1]{\testdate@pdf[{#1}]{#1}}

% Only for the PDF (use \@author as in "article")
\def\@author{Christophe.Troestler@umons.ac.be}
\newcommand{\testauthor}[1]{\gdef\@author{#1}}

\newcommand{\nom@name}{\translate{Name}\xspace :}
\newcommand{\prenom@name}{\translate{Firstname}\xspace :}
\newcommand\nom@hook{}
\newcommand\prenom@hook{}
\newcommand{\testnomname}[1]{\gdef\nom@hook@change{#1}}% deprecated
\newcommand{\testprenomname}[1]{\gdef\prenom@hook@change{#1}}% deprecated
\newcommand{\testlastname}[1]{%
  \def\nom@hook@tmp{#1}%
  \ifx \nom@hook@tmp\empty
    \iftest@want@rulers \gdef\nom@hook@change{\nom@hook@rulers}%
    \else               \gdef\nom@hook@change{}\fi
  \else
    \gdef\nom@hook@change{\ #1}% include initial space
  \fi}
\newcommand{\testfirstname}[1]{%
  \def\prenom@hook@tmp{#1}%
  \ifx \prenom@hook@tmp\empty
    \iftest@want@rulers \gdef\prenom@hook@change{\prenom@hook@rulers}%
    \else               \gdef\prenom@hook@change{}\fi
  \else
    \gdef\prenom@hook@change{\ #1}%
  \fi}

\testlastname{}% Only takes effect at \maketitle
\testfirstname{}

\newcommand\section@hook@change{}
\newcommand{\testsection}[1]{%
  \def\section@hook@tmp{#1}%
  \ifx \section@hook@tmp\empty % default (see later)
    \iftest@want@rulers \gdef\section@hook@change{\section@hook@rulers}%
    \else               \gdef\section@hook@change{}%
    \fi
  \else % replace
    \gdef\section@hook@change{#1}%
  \fi}
\testsection{}

%% If one needs to change ``Mathematique Elementaire'' to something else:
\newcommand\test@title@change{Math\'ematique \'El\'ementaire}
\newcommand{\test@title@firstpage@change}{\test@title@change}
\newcommand{\testtitle}[2][]{%
  \gdef\test@title@firstpage@change{#2}%
  \xdef\@temp{#1}%
  \ifx \@temp\empty \gdef\test@title@change{#2}%
  \else \gdef\test@title@change{#1}\fi}

%% `Test' title is not always right, we also want to typeset exams...
\newcommand\test@thetest@change{\translate{Test no}\thinspace\test@number}
\newcommand\test@thetestpdf@change{\translate{Test} \test@number}

\newcommand{\testtype}{%
  \@ifnextchar[{\testtype@pdf}{\testtype@equalpdf}}
\newcommand\testtype@equalpdf[1]{%
  \gdef\test@thetest@change{#1}%
  \gdef\test@thetestpdf@change{#1}}
\def\testtype@pdf[#1]#2{%
  \gdef\test@thetest@change{#2}%
  \gdef\test@thetestpdf@change{#1}}

\newcommand{\exam}{\testtype{\translate{Exam}}}
\newcommand{\cote}{\testtype{\translate{Rated exercise}}}


% If several ``independent'' tests in a single document:
\newcounter{test@part}
\setcounter{test@part}{0}
\newcounter{test@offset@page}% to substract to the current page
\setcounter{test@offset@page}{0}
\newcounter{test@tmp}

% Hold the page offset until the new test is started:
\newcommand{\test@offset@page@change}{0}

\newcommand{\thetotalpage}{%
  \expandafter\ref{test:totalpages-\the\c@test@part}}

\newcommand{\test@set@totalpages}{%
  % To be called on the last page of the current test.
  \setcounter{test@tmp}{\value{page}}%
  \addtocounter{test@tmp}{\value{test@offset@page}}%
  % Does not work after the document is closed.  Must save label by hand.
  % \edef\@currentlabel{\the\c@test@tmp}% # of pages
  % \expandafter\label{test:totalpages-\the\c@test@part}%
  \ltx@ifpackageloaded{hyperref}{%
    \immediate\write\@auxout{\string\newlabel{test:totalpages-\the\c@test@part}%
      {{\the\c@test@tmp}{\thepage}{}{}{}}}%
  }{%
    \immediate\write\@auxout{\string\newlabel{test:totalpages-\the\c@test@part}%
      {{\the\c@test@tmp}{\thepage}}}%
  }%
  % Change to activate at the beginning of the new test:
  \edef\test@offset@page@change{-\the\c@page}%
}

\newcommand{\test@thepage}{{%
    \setcounter{test@tmp}{\value{page}}%
    \addtocounter{test@tmp}{\value{test@offset@page}}%
    \arabic{test@tmp}%
    %\thepage
  }}

\AfterLastShipout{%
  \begingroup
  \addtocounter{page}{-1}% last page was outputted
  \test@set@totalpages
  \endgroup}

%% Same as \def#1{#2} except that #2 is expanded _1_ level.  This is
%% specifically to "activate" the waiting changes, hold in some
%% macros.  (\edef expands too much.)
\newcommand\test@defexpand[2]{%
  \expandafter\gdef\expandafter#1\expandafter{#2}%
}

\newcommand{\test@activate@changes}{%
  \addtocounter{test@part}{1}% new test
  \typeout{-- Test \arabic{test@part} --}%
  %% Activate the changes (expand now):
  %\message{--- Activating the changes. ---}
  \test@defexpand\test@number{\test@number@change}%
  \test@defexpand\test@date{\test@date@change}%
  \test@defexpand\test@datepdf{\test@datepdf@change}%
  \test@defexpand\nom@hook{\nom@hook@change}%
  \test@defexpand\prenom@hook{\prenom@hook@change}%
  \test@defexpand\section@hook{\section@hook@change}%
  \test@defexpand\test@title@firstpage{\test@title@firstpage@change}%
  \test@defexpand\@title{\test@title@change}%
  \test@defexpand\test@thetest{\test@thetest@change}%
  \test@defexpand\test@thetestpdf{\test@thetestpdf@change}%
  \setcounter{test@offset@page}{\test@offset@page@change}%
}

\AtBeginDocument{%
  \test@activate@changes
  \tests@FirstPage}

% After \begin{document}, one may want to start another test in the 
% same file
% With a star: Same test but different course,... (merging)
% Without: ``independent'' test, optional arg to redefine
\renewcommand\maketitle{\@ifstar{\maketitle@cont}{\maketitle@new}}
\newcommand\maketitle@cont{
  \newpage
  \test@activate@changes
  \tests@FirstPage
}
\newcommand\maketitle@new{%
  \null
  \test@set@totalpages
  \newpage
  \test@activate@changes
  \setcounter{test@question}{0}%
  \setcounter{equation}{0}%
  \setcounter{footnote}{0}%
  \setcounter{figure}{0}%
  % Do not let \hyper@refstepcounter treat equations specially because
  % that generates name clashes.
  \edef\name@of@eq{no-equation}%
  \def\theHequation{\arabic{equation}-\arabic{test@part}}%
  % Name clashes also happen for pages.  Since I do not know how to
  % avoid it, I set an offset used to display it.
  %\setcounter{page}{1}%
  \tests@FirstPage
}



\newcommand\ps@firstpage{%
  \renewcommand\@mkboth[2]{}%
  \renewcommand\@oddhead{}%
  \renewcommand\@oddfoot{\reset@font \hfil \test@thepage/\thetotalpage}%
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot}

  
\newlength{\test@titleskip}    \setlength{\test@titleskip}{6pt}
\newlength{\test@rulethickness}\setlength{\test@rulethickness}{0.5pt}
\newcommand\test@beforetext{3ex}

\iftest@logo
%% UMONS logo
%%......................................................................
\newcommand\tests@FirstPage{{%
  \vspace*{-19mm}%
  \thispagestyle{firstpage}%
  \setbox0=\hbox{\includegraphics[height=15mm]{\test@logo@file}}%
  \noindent
  \vbox to\ht0{%
    \halign{##\hfil\crcr
      {\test@titlefont    \test@title@firstpage}\cr
      \noalign{\vfill}
      \test@numberfont   \test@thetest %% Test n°...
      \ifx\test@date\empty \else  
      \qquad \hfill \test@namesfont (\test@date)\fi
      {\test@namesfont\strut}% make sure you get the correct depth
      \cr
    }}%
  \hfill \kern 3mm
  \box 0
  \vspace*{6pt}\hrule height 2\test@rulethickness
  \par\vspace*{\test@beforetext}}}

\else
\iftest@correction
%% Correction of the test
%%......................................................................
\newcommand\tests@FirstPage{{%
  \vspace*{-22mm}%
  \thispagestyle{firstpage}%
  \setbox0=\hbox{{\test@correction \rotatebox{10}{Correction}}}%
  \noindent
  \vbox to\ht0{%
    \halign{##\hfil\crcr
      {\test@titlefont    \test@title@firstpage}\cr
      \noalign{\vfill}
      \test@numberfont   \test@thetest %% Test n°...
      \ifx\test@date\empty \else  
      \qquad \hfill \test@namesfont (\test@date)\fi
      {\test@namesfont\strut}% make sure you get the correct depth
      \cr
    }}%
  \hfill
  \box 0
  \vspace*{6pt}\hrule height 2\test@rulethickness
  \par\vspace*{\test@beforetext}}}

\else
%% Test (not correction)
%%......................................................................
\newcommand\tests@FirstPage{{%
  \vspace*{-25mm}%
  \thispagestyle{firstpage}%
  \setbox0=\vbox{% Box for `nom',... to fill
    \test@namesfont
    \offinterlineskip
    \halign to 55mm{\vrule width \test@rulethickness ##&
        \strut \ ##\hfil\tabskip 0pt plus 1000pt& 
        \vrule width \test@rulethickness ##\tabskip 0pt\crcr
      \noalign{\hrule height \test@rulethickness depth 0pt}
      height \test@titleskip&\omit&\cr %% extra vspace
      &\nom@name \nom@hook &\cr
      height \test@titleskip&\omit&\cr
      &\prenom@name \prenom@hook &\cr
      height \test@titleskip&\omit&\cr
      &\translate{Section}\xspace : \section@hook &\cr
      height .5\test@titleskip&\omit&\cr
      \noalign{\hrule  height \test@rulethickness depth 0pt}}}%
  %
  \noindent
  \vbox to \ht0{%
    \halign{##\hfil\crcr
      \noalign{\vskip\test@titleskip \vspace*{\test@rulethickness}}
      {\test@titlefont    \test@title@firstpage}\cr
      \noalign{\vfill}
      \test@numberfont   \test@thetest %% Test n°...
      {\test@namesfont\strut % make sure you get the correct depth
        \ifx\test@date\empty \else \qquad \hfill (\test@date)\fi
      }%
      \cr
      \noalign{\vskip.5\test@titleskip \vspace*{\test@rulethickness}}}}
  \hfill 
  \box0
  \vspace*{6pt}\hrule height 2\test@rulethickness
  \par\vspace*{\test@beforetext}}}

\fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                        O T H E R    P A G E S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\iftest@logo
%% UMONS logo
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand{\@oddhead}{{%
      \setbox0=\hbox{\includegraphics[height=11mm]{\test@logo@file}}%
      \vbox to 0pt{\vss
        \vbox to\ht0{%
          \halign to\textwidth{####\hfil \tabskip=0pt plus 1000pt&
            ####\tabskip=0pt\crcr
            {\test@smalltitlefont    \@title}\cr
            \noalign{\vfill}%
            \test@namesfont\strut   \test@thetest %% Test n°...
            \ifx\test@date\empty \else  \qquad \hfill
            \test@smallnamesfont (\test@date)\fi
            &\smash{\box 0}\cr
          }}%
        \vspace*{.5\test@titleskip}
        \hrule height 2\test@rulethickness width\hsize
      }}}%
  \renewcommand\@oddfoot{\reset@font \hfil \test@thepage/\thetotalpage}%
  \let\@evenhead\@empty 
  \let\@evenfoot\@oddfoot}

\else
\iftest@correction
%% Correction of the test
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand\@oddhead{{%
      \setbox0=\hbox{{\test@smallcorrection \rotatebox{10}{Correction}}}%
      \vbox to 0pt{\vss
        \vbox to\ht0{%
          \halign to\textwidth{####\hfil \tabskip=0pt plus 1000pt&
            ####\tabskip=0pt\crcr
            {\test@smalltitlefont    \@title}\cr
            \noalign{\vfill}%
            \test@namesfont\strut   \test@thetest %% Test n°...
            \ifx\test@date\empty \else  \qquad \hfill
            \test@smallnamesfont (\test@date)\fi
            &\smash{\box 0}\cr
          }}%
        \vspace*{.5\test@titleskip}
        \hrule height 2\test@rulethickness width\hsize
      }}}%
  \renewcommand\@oddfoot{\reset@font \hfil \test@thepage/\thetotalpage}%
  \let\@evenhead\@empty 
  \let\@evenfoot\@oddfoot}

\else
%% Test (not correction)
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand\@oddhead{{%
    \setbox0=\vbox{%
      \multiply\test@rulethickness by2
      \test@namesfont
      \offinterlineskip
      \halign to 55mm{\vrule width \test@rulethickness ####&
          \strut \ ####\hfil\tabskip 0pt plus 1000pt& 
          \vrule width \test@rulethickness ####\tabskip 0pt\crcr
        \noalign{\hrule height \test@rulethickness depth 0pt}%
        height \test@titleskip&\omit&\cr %% extra vspace
        &\nom@name \nom@hook &\cr
        height \test@titleskip&\omit&\cr
        &\prenom@name \prenom@hook &\cr
        height \test@titleskip&\omit&\cr
        &\translate{Section}\xspace : \section@hook &\cr
        height .5\test@titleskip&\omit&\cr
        \noalign{\hrule height \test@rulethickness depth 0pt}}}%
    %%
%     \vbox to 0pt{\vss
%       \noindent
%       \vbox to \ht0{%
%         \halign{####\hfil\crcr
%           \noalign{\vspace*{\test@titleskip}\vspace*{\test@rulethickness}}%
%           \test@titlefont  \test@smalltitlefont    
%           \@title\cr
%           \noalign{\vfill}%
%           \test@numberfont \test@namesfont\strut
%           Test n$^\circ$\thinspace\test@number
%           \ifx\test@date\empty \else  \hfill \test@namesfont (\test@date)\fi
%           {\test@namesfont\strut}% make sure you get the correct depth
%           \cr
%           \noalign{\vspace*{.5\test@titleskip}\vspace*{\test@rulethickness}}%
%           }%
%         }%
%       \hfill 
    %% Second solution
    %% ~~~~~~~~~~~~~~~
    \vbox to 0pt{\vss
      \noindent
      \setlength{\@tempdima}{\textwidth}%
      \addtolength{\@tempdima}{-\wd0}%
      \vtop{\hsize=\@tempdima  \addtolength{\baselineskip}{20pt}%
        \halign{####\hfil\crcr
          \noalign{\vspace*{\test@titleskip}\vspace*{\test@rulethickness}}%
          {\test@smalltitlefont    \@title}\cr
          \noalign{\vfill}%
          \test@namesfont\strut   \test@thetest %% Test n°...
          \ifx\test@date\empty \else  \qquad \hfill
          \test@smallnamesfont (\test@date)\fi
          \cr
          \noalign{\vspace*{.5\test@titleskip}}
          }%
        \par\hrule height 2\test@rulethickness width\hsize
        }%
      \hfill 
      \smash{\vtop{\unvbox0}}\par
      \hrule height 0pt depth 0pt %% This is the \vbox baseline...
      }%
    }}%
  \renewcommand\@oddfoot{\reset@font \hfil \test@thepage/\thetotalpage}%
  \let\@evenhead\@empty 
  \let\@evenfoot\@oddfoot}

\fi
\fi
%%......................................................................

\pagestyle{test}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                 R U L E R S (for writing name,...)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\tests@onechar[1][3mm]{%
  \leavevmode
  \raisebox{-3pt}{%
    \vrule width 0.7pt depth 0.7pt height2pt
    \vrule width #1 height0pt depth 0.7pt
    \rlap{\vrule width 0.7pt depth 0.7pt height2pt}%
  }}

\iftest@want@rulers

\newcommand\nom@hook@rulers{\bgroup
  \color[gray]{0.5}%
  \hspace{3pt}%
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \tests@onechar\tests@onechar
  \egroup}

\newcommand\prenom@hook@rulers{\bgroup
  \color[gray]{0.5}%
  \hspace{3pt}%
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \egroup}

\newcommand{\section@hook@rulers}{{%
  \color[gray]{0.5}%
  \hspace{3pt}%
  \tests@onechar[5mm]\tests@onechar[5mm]%
  \tests@onechar[5mm]\tests@onechar[5mm]\tests@onechar[5mm]}}

\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                           A B S T R A C T
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewenvironment{abstract}{%
  \vspace*{-\test@beforetext}\vspace*{6pt}%
  \begin{quote}
    \small
  }{%
  \end{quote}
  \vspace*{2pt}  \hrule height 1pt
  \vspace*{\test@beforetext}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            P A R T S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% L'examen d'Analyse comporte deux parties (2 cours).
\renewcommand{\part}[1]{%
  \colorbox[gray]{.8}{\begin{minipage}{0.985\linewidth}\centering%
      \vrule height 2.2ex width 0pt depth 0.2ex
      #1\relax
      \vrule height 2.2ex width 0pt depth 0.2ex
    \end{minipage}}%
  \medskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                          Q U E S T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{test@question}
\setcounter{test@question}{0}

% Save the default \linewidth (useful if the question is inside a
% minipage with its local \linewidth).
\newlength{\question@linewidth}
\AtBeginDocument{\setlength{\question@linewidth}{\linewidth}}

%% Optional [comment]
%% Optional <mark>
\newenvironment{question}[1][]{%
  \stepcounter{test@question}%
  \edef\question@comment{#1}%
  \make@question{%
    \ifx \question@comment \empty \translate{Question}~\arabic{test@question}.
    \else
    \make@question{\translate{Question}~\arabic{test@question}
      \ignorespaces #1.}%
    \fi
  }%
}{%
  \par
  \iftest@correction \vspace{2ex plus 6ex}\else \vspace{4ex}\fi
}

\newenvironment{question*}{%
  \make@question{\translate{Question}~\arabic{test@question}
    (\translate{sequel}).}%
}{%
  \par
  \iftest@correction \vspace{2ex plus 6ex}\else \vspace{4ex}\fi
}

\newcommand{\make@question}[1]{%
  \@ifnextchar<{\make@question@withmark{#1}}{\make@question@{#1}}}

\def\make@question@withmark#1<#2>{%
  \@ifnextchar[{\make@question@withmarkdist{#1}{#2}}{%
    \make@question@withmarkdist{#1}{#2}[\question@linewidth]}}

%% Display mark for the question
\def\make@question@withmarkdist#1#2[#3]{%
  \iftest@correction\else
    \noindent
    \rlap{\smash{\hspace*{#3}\hspace*{7mm}%
        %$\left/ \vrule height 3ex width0pt\right.$}
        \raisebox{-2ex}{%
          \raisebox{-0.5ex}{%
            \rotatebox{60}{\vrule height 1pt depth 0pt width 6ex}}%
          \kern-1.ex\hbox{\large\textsf{#2}}}}}%
  \fi
  \make@question@{#1}%
}

\newcommand\make@question@[1]{%
  \gdef\@currentlabel{\arabic{test@question}}%
  \iftest@correction \vspace{3ex plus 3ex minus 1ex}\pagebreak[2]\fi
  \noindent\textsf{#1}\quad
  \iftest@correction \itshape \else \upshape\fi
  \ignorespaces
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                       C O R R E C T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\iftest@correction

\newenvironment{answer}{%
  \par
  \noindent
  \upshape
  \ignorespaces
}{%
  \par
  \vspace{2ex plus 6ex minus 0.5ex}%
  \ignorespaces
}


\newcommand{\inlineanswer}[1]{{%
    \upshape
    \ignorespaces
    #1}}


\else

\newenvironment{answer}{%
  \comment
}{%
  \endcomment
}
\newcommand{\inlineanswer}[1]{}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                   N A M E   Q U E S T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\namedquestion}[2]{% <name> <number>
  \@ifundefined{tests@named@#1@#2}{%
    \PackageError{tests}{%
      Number #2 of named question `#1' doesn't exist.^^J\space\space%
      Possible values are 1..\the\value{tests@named@#1}}{%
    Change the number in \string\namedquestion{#1}{#2}^^J%
    so that it is in the range 1..\the\value{tests@named@#1}.}}{%
    \csname tests@named@#1@#2\endcsname}}

% Save the content
\newenvironment{namequestion}[1]{% <name>
  \@ifundefined{c@tests@named@#1}{% New named question
    \newcounter{tests@named@#1}}{}%
  \stepcounter{tests@named@#1}%
  \edef\@tempa{\expandafter\the\value{tests@named@#1}}%
  \edef\tests@dest@name{% name to store the environment content
    \expandafter\csname tests@named@#1@\@tempa\endcsname}%
  \global\toks@{}%
  \tests@get@env@body@start%
}{%
  \expandafter\expandafter\expandafter
    \gdef\expandafter\tests@dest@name\expandafter{\the\toks@}%
}

% Copied from package "collect":

\def\tests@get@env@body@start{%
\let\@tempa\tests@get@env@body%
\futurelet\@tempb\tests@get@env@body@start@%
}
\def\tests@get@env@body@start@{%
\ifx\@tempb\@sptoken%
\expandafter\tests@get@env@body@start@@%
\else%
\expandafter\tests@get@env@body%
\fi%
}
\def\tests@get@env@body@start@@{%
\afterassignment\tests@get@env@body%
\let\@tempb= %
}

\bgroup
\catcode`\Q=3

\long\gdef\tests@get@env@body#1\end#2{%
\def\@tempb{#2}%
\ifx\@tempb\@currenvir%
\tests@get@env@body@#1Q Q%
\def\@tempa{\end{#2}}%
\else
\toks@\expandafter{\the\toks@#1\end{#2}}%
\fi
\@tempa
}

\long\gdef\tests@get@env@body@#1 Q{%
  \tests@get@env@body@@#1Q%
}

\long\gdef\tests@get@env@body@@#1Q#2{%
  \toks@\expandafter{\the\toks@#1}%
}
\egroup


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                G E N E R A T E   F R O M   C S V
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This section is heavily inspired from the package "csvsimple".

\bgroup
\catcode`\Q=3 % Q is "math shift"
% Remove leading and trailing spaces from the content of macro #1
\gdef\tests@CSV@TrimSpaces#1{%
  \begingroup
  \aftergroup\toks\aftergroup0\aftergroup{%
    \expandafter\tests@CSV@trimb\expandafter\noexpand#1Q Q}%
  \global\edef#1{\the\toks0}%
}
\gdef\tests@CSV@trimb#1 Q{\tests@CSV@trimc#1Q}
\gdef\tests@CSV@trimc#1Q#2{% Eat leading spaces
  \afterassignment\endgroup \vfuzz\the\vfuzz#1}
\egroup

% Remove braces
\def\tests@CSV@TrimBraces#1{\expandafter\tests@CSV@TrimBraces@#1\@nil{#1}}
\def\tests@CSV@TrimBraces@#1\@nil#2{\def#2{#1}}

\newcounter{tests@CSVcol}

% Break the line according to \tests@CSV@breakline (defined later
% depending on the separator) and put each column in
% \tests@CSVcol⟨number⟩.
\def\tests@CSV@breakline@kernel#1{%
  \ifx\tests@CSV@termination#1\let\nextcol=\relax\else
    \let\nextcol=\tests@CSV@breakline
    \global\advance\c@tests@CSVcol 1\relax
    \def\tests@CSV@col@body{#1}%
    \tests@CSV@TrimSpaces\tests@CSV@col@body
    \tests@CSV@TrimBraces\tests@CSV@col@body
    \toks@\expandafter{\tests@CSV@col@body}%
    \expandafter
    \xdef\csname tests@CSVcol\romannumeral\c@tests@CSVcol\endcsname{\the\toks@}%
  \fi
  \nextcol
}

% comma
\def\tests@CSV@breakline@comma#1,{\tests@CSV@breakline@kernel{#1}}

\def\tests@CSV@scanline@comma#1{%
  \global\c@tests@CSVcol 0\relax
  \tests@CSV@breakline#1,\tests@CSV@termination,}

% semicolon
\def\tests@CSV@breakline@semicolon#1;{\tests@CSV@breakline@kernel{#1}}

\def\tests@CSV@scanline@semicolon#1{%
  \global\c@tests@CSVcol 0\relax
  \tests@CSV@breakline#1;\tests@CSV@termination;}

% Key to choose the separator
\define@key{tests@CSV}{separator}{%
  \ifthenelse{\equal{#1}{comma}}{%
    \global\let\tests@CSV@scanline=\tests@CSV@scanline@comma
    \global\let\tests@CSV@breakline=\tests@CSV@breakline@comma
  }{%
    \ifthenelse{\equal{#1}{semicolon}}{%
      \global\let\tests@CSV@scanline=\tests@CSV@scanline@semicolon
      \global\let\tests@CSV@breakline=\tests@CSV@breakline@semicolon
    }{%
      \PackageError{tests}{Option `separator' only accepts `comma' and %
        `semicolon' as values.}{}}}}

% Expands a CSV line and scans content
\def\tests@CSV@escanline#1{%
  \toks@\expandafter{#1}%
  \edef\tests@@CSV@scanline{\noexpand\tests@CSV@scanline{\the\toks@}}%
  \tests@@CSV@scanline%
}

% #1 is the header name.  This macro apply \macro to
% \tests@CSVcol⟨number⟩ (which contains the cell content).  It is
% supposed to be used after a line has been scanned.  A missing name
% is the same as an empty cell.
\def\tests@CSV@apply#1#2{% ⟨\macro⟩ ⟨header name⟩
  \@ifundefined{tests@CSVcolofname@#2}{}{%
    \edef\tests@CSV@column{\csname tests@CSVcolofname@#2\endcsname}%
    \expandafter\let\expandafter\tests@CSV@content
        \csname\tests@CSV@column\endcsname
    \expandafter#1\expandafter{\tests@CSV@content}%
  }}

\newread\tests@CSV@file

\let\tests@CSV@par=\par
\def\tests@CSV@readline{\global\read\tests@CSV@file to\tests@CSVline}

\def\tests@CSV@processheadline{%
  \tests@CSV@readline
  \if\tests@CSV@par\tests@CSVline\relax
    \PackageError{tests}{%
      File `\tests@CSV@input@filename' starts with an empty line!}{}%
  \fi
  \tests@CSV@escanline{\tests@CSVline}%
  \xdef\tests@CSV@columncount{\thetests@CSVcol}%
  \global\c@tests@CSVcol 0\relax
  \loop
    \global\advance\c@tests@CSVcol 1\relax
    % Expand \tests@CSVcolofname@⟨header⟩ into tests@CSVcol⟨number⟩
    \edef\tests@CSV@column{tests@CSVcol\romannumeral\c@tests@CSVcol}%
    \edef\tests@CSV@header{\csname\tests@CSV@column\endcsname}%
    \edef\tests@CSV@destname{%
      \csname tests@CSVcolofname@\tests@CSV@header\endcsname}%
    \expandafter\expandafter\expandafter
    \def\expandafter\tests@CSV@destname\expandafter{\tests@CSV@column}%
  \ifnum\c@tests@CSVcol<\tests@CSV@columncount\repeat
}

\def\tests@CSV@loop@questions#1,{%
  \ifx\relax#1\@empty \else
  \KV@@sp@def\@tempa{#1}%
  \def\tests@CSV@question{\namedquestion{\@tempa}}%
  \tests@CSV@apply\tests@CSV@question{\@tempa}%
  \expandafter\tests@CSV@loop@questions \fi}

\newcommand{\generatetestsfromCSV}[3][]{% [options] <CSV filename> <questions>
  \global\let\tests@CSV@scanline=\tests@CSV@scanline@comma
  \global\let\tests@CSV@breakline=\tests@CSV@breakline@comma
  \setkeys{tests@CSV}{#1}%
  % Process the first "header" line
  \gdef\tests@CSV@input@filename{#2}%
  \openin\tests@CSV@file=\tests@CSV@input@filename\relax
  \ifeof\tests@CSV@file
    \PackageError{tests}{File `\tests@CSV@input@filename' not existent, %
      not readable, or empty!}{}%
  \else
    \tests@CSV@processheadline
    % Loop over other lines
    \gdef\tests@CSV@loop{%
      \ifeof\tests@CSV@file
        \global\let\test@CSV@next=\relax
      \else
        \global\let\test@CSV@next=\tests@CSV@loop
        \tests@CSV@readline
        \if\tests@CSV@par\tests@CSVline \else
          \tests@CSV@escanline{\tests@CSVline}%
          % Generate a new test from the data
          \tests@CSV@apply\testlastname{Nom}%
          \tests@CSV@apply\testfirstname{Prenom}%
          \maketitle
          \tests@CSV@loop@questions #3,\relax,%
        \fi
      \fi
      \test@CSV@next}%
    \tests@CSV@loop
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                         M I S C.   T O O L S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\labelitemi}{{\vrule depth 0pt width .8ex height .8ex}}
\renewcommand{\labelitemii}{{$\scriptstyle\blacktriangleright$}}

\renewenvironment{itemize}{%
  \ifnum\@itemdepth >\thr@@ \@toodeep   \else 
  \advance\@itemdepth\@ne  
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \expandafter\list \csname\@itemitem\endcsname {%
    \setlength{\topsep}{0.5ex}%
    \setlength{\itemindent}{0pt}%
    \setlength{\labelwidth}{\itemindent}%
    \setlength{\labelsep}{1ex}%
    \setlength{\itemsep}{0.1ex}%
    \setlength{\leftmargin}{1.8em}%
    \def\makelabel##1{\hss \llap{##1}}}%
  \fi
}{%
  \global\advance\@listdepth\m@ne \endtrivlist
}
  
\AtBeginDocument{%
  \@ifundefined{frenchbsetup}{%
    \@ifundefined{StandardLayout}{}{\StandardLayout}%
  }{\frenchbsetup{StandardLayout}}
}



\newenvironment{itemizetext}{%
  \ifnum\@itemdepth >\thr@@ \@toodeep   \else 
  \advance\@itemdepth\@ne  
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \expandafter\list \csname\@itemitem\endcsname {%
    \setlength{\topsep}{3pt}%
    \setlength{\leftmargin}{0pt}%
    \setlength{\itemindent}{2.3ex}%
    \setlength{\labelwidth}{0pt}%
    \setlength{\labelsep}{5.87494pt}%
    \def\makelabel##1{\hss \llap{##1}}}%
  \fi
}{%
  \global\advance\@listdepth\m@ne \endtrivlist
}





%% enumerate
%%----------------------------------------------------------------------
\renewcommand\theenumi{\alph{enumi}}
\renewcommand\labelenumi{(\theenumi)}

\renewcommand\theenumii{\roman{enumii}}
\renewcommand\labelenumii{(\theenumii)}

\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >\thr@@ \@toodeep 
  \else 
    \advance\@enumdepth\@ne 
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter\list \csname label\@enumctr \endcsname {%
      \usecounter\@enumctr
      \ifdim\parindent<2.3em \leftmargin=2.3em \else \leftmargin=\parindent \fi
      \setlength{\itemindent}{0pt}%
      \setlength{\topsep}{10.0pt plus 4.0pt minus 6.0pt}%
      \setlength{\itemsep}{5.0pt plus 2.5pt minus 1.0pt}%
      \def\makelabel##1{\hss\llap{\textsf{##1}}}%
    }%
  \fi
}{%
  \global\advance\@listdepth\m@ne 
  \endtrivlist 
}

\newenvironment{enumeratetext}{%
  \ifnum \@enumdepth >\thr@@ \@toodeep 
  \else 
    \advance\@enumdepth\@ne 
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter\list \csname label\@enumctr \endcsname {%
      \usecounter\@enumctr 
      \setlength{\topsep}{3pt}%
      \setlength{\itemindent}{1.8em}%
      \setlength{\labelwidth}{\itemindent}%
      \setlength{\labelsep}{0pt}%
      \setlength{\itemsep}{7pt plus 2pt}%
      \setlength{\leftmargin}{0pt}%
      \def\makelabel##1{\textsf{##1}\hss}%
    }%
  \fi
}{%
  \global\advance\@listdepth\m@ne 
  \endtrivlist 
}

%% True/False questions
%%----------------------------------------------------------------------

\newcommand{\testsTrueLabel}{\translate{True}\xspace :}
\newcommand{\testsFalseLabel}{\translate{False}\xspace :}

\newcommand{\tests@TF@drawbox}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.7ex depth 0.3ex\hskip 2ex}}%
      \hrule}\vrule}}

\AtBeginDocument{% Choose the symbol for the tick
  \ifx\ding\@undefined
    \ifx\checkmark\@undefined
    \newcommand{\teststick}{$\times$}%
    \else
    \newcommand{\teststick}{$\checkmark$}%
    \fi
  \else
    \newcommand{\teststick}{\ding{51}}%
  \fi}

\newcommand{\tests@TF@tickedbox}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.7ex depth 0.3ex
          \hbox to 2ex{\hss \teststick \hss}}}%
      \hrule}\vrule}}

\newcommand{\tests@TF@drawbox@large}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.8ex depth 0.5ex\hskip 2.2ex}}%
      \hrule}\vrule}}

\newcommand{\tests@TF@drawbox@large@ticked}{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.8ex depth 0.5ex
          \hbox to 2.2ex{\hss \teststick \hss}}}%
      \hrule}\vrule}}

\newcounter{TrueFalse}

\def\tests@TF@number{\hbox to 1.8em{\textsf{(\theTrueFalse)}\hss}}

% For corrections: allow to put a tick

\let\tests@TF@item@orig=\item
\newif\iftests@TF@item@thickT
\newif\iftests@TF@item@thickF

\define@key{tests@TF}{true}[true]{\csname tests@TF@item@thickT#1\endcsname}
\define@key{tests@TF}{false}[true]{\csname tests@TF@item@thickF#1\endcsname}

\newcommand{\tests@TF@item}[1][]{%
  % Optional arguments "true" and "false" to tick the box.
  \tests@TF@item@thickTfalse
  \tests@TF@item@thickFfalse
  \setkeys{tests@TF}{#1}%
  \tests@TF@item@orig}

% Label "True □ False □", with boxes to tick.
% Optional argument "true" and "false" to tick tha appropriate box.
\newenvironment{TrueFalse}{\bgroup
  \def\tests@TF@label{\tests@TF@number
    \testsTrueLabel\
    \iftests@TF@item@thickT \tests@TF@tickedbox \else \tests@TF@drawbox\fi\quad
    \testsFalseLabel\
    \iftests@TF@item@thickF \tests@TF@tickedbox \else \tests@TF@drawbox\fi}%
  \let\item\tests@TF@item % locally
  \begin{tests@TF@gen}
  }{%
  \end{tests@TF@gen}
  \egroup}

% Boxes to tick (no "True"/"False").
% Optional argument "true" to tick the box.
\newenvironment{TrueFalse*}[1][]{\bgroup
  \def\tests@TF@label{\tests@TF@number
    \iftests@TF@item@thickT \tests@TF@drawbox@large@ticked
    \else \tests@TF@drawbox@large\fi}%
  \let\item\tests@TF@item % locally
  \begin{tests@TF@gen}
  }{%
  \end{tests@TF@gen}
  \egroup}

\newenvironment{tests@TF@gen}{%
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
      \tests@TF@label
    }{%
      \settowidth{\labelwidth}{\tests@TF@label}
      \addtolength{\labelwidth}{6pt}
      \settowidth{\leftmargin}{\tests@TF@number}
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
  \def\tests@TF@label{#1\tests@TF@drawbox@large}%
  \begin{tests@TF@gen}
  }{%
  \end{tests@TF@gen}
  \egroup}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                               P D F
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{%
    \RequirePackage{color}%
    \definecolor{test@green}{rgb}{0.56862745,0.78039216,0.63137255}% #91c7a1
    \definecolor{test@darkgreen}{rgb}{0.4,0.47,0.42}% #667a6a
    \definecolor{test@blue}{rgb}{0.23,0.85,0.98}% #3ad9fc
    \definecolor{test@darkblue}{rgb}{0.23,0.33,0.95}%
    \definecolor{test@metalblue}{rgb}{0.21,0.67,0.61}%
    \definecolor{test@red}{rgb}{0.67,0.03,0.06}%
    \hypersetup{%
      %% Changes (to \test@thetestpdf,...) must have been applied.
      pdfauthor={\@author},
      pdfkeywords={Mathematical tests},
      pdfsubject={\@title},
      pdfpagemode=UseNone,
      pdfstartview=FitH,
      colorlinks=true,
      urlcolor=test@darkgreen,
      citecolor=test@red,
      linkcolor=test@darkblue
    }%
    \ifx \test@datepdf\empty
    \hypersetup{%
      pdftitle={\test@thetestpdf\space (\@title)}}%
    \else
    \hypersetup{%
      pdftitle={\test@thetestpdf\space (\test@datepdf)}}%
    \fi
  }{}%
}

\AtBeginDocument{% Must be put there to account for packages modif color
  \@ifpackageloaded{color}{%
    \definecolor{umons-red}{cmyk}{0., 1., 0.6, 0.2}
    \definecolor{umons-gray}{cmyk}{0, 0, 0, 0.5}
    \definecolor{umons-turquoise}{cmyk}{0.9, 0., 0.2, 0.}
  }{}%
}

\endinput
