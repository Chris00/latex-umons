\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{tests}[2000/01/04 v0.1 ^^J
  \space
  Presentation des tests de Mathematique elementaire.]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            O P T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\iftest@want@rulers \test@want@rulersfalse
\DeclareOption{rulers}{\test@want@rulerstrue}

\newif\iftest@correction \test@correctionfalse
\DeclareOption{correction}{\test@correctiontrue}

\newif\iftest@umons \test@umonsfalse
\DeclareOption{umons}{\test@umonstrue}% No name, UMONS logo

\newif\iftest@mps \test@mpsfalse
\DeclareOption{mps}{\test@mpstrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions
\LoadClass{article}

\RequirePackage{a4}
\RequirePackage{graphics}
\addtolength{\textwidth}{2cm}
\addtolength{\oddsidemargin}{-1cm}
\addtolength{\textheight}{2cm}
\setlength{\parindent}{0pt}

%\RequirePackage[T1]{fontenc}
%\RequirePackage[francais]{babel}
%\RequirePackage{times}

\iftest@want@rulers
\RequirePackage{color}
\fi
\iftest@correction
\RequirePackage{graphics,color}
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

\newcommand{\nom@name}{Nom~:}
\newcommand{\prenom@name}{Pr\'enom~:}
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
\newcommand\test@thetest@change{Test n$^\circ$\thinspace\test@number}
\newcommand\test@thetestpdf@change{Test \test@number}

\newcommand{\testtype}{%
  \@ifnextchar[{\testtype@pdf}{\testtype@equalpdf}}
\newcommand\testtype@equalpdf[1]{%
  \gdef\test@thetest@change{#1}%
  \gdef\test@thetestpdf@change{#1}}
\def\testtype@pdf[#1]#2{%
  \gdef\test@thetest@change{#2}%
  \gdef\test@thetestpdf@change{#1}}

\newcommand{\exam}{\testtype{Examen}}
\newcommand{\cote}{\testtype[Coté]{Cot\'e}}%% !! 'é' latin1 not TeX encoded !!


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
  \edef\@currentlabel{\the\c@test@tmp}% # of pages
  \expandafter\label{test:totalpages-\the\c@test@part}%
  % Change to activate at the beginning of the new test:
  \edef\test@offset@page@change{-\the\c@page}%
}

\newcommand{\test@thepage}{{%
    \setcounter{test@tmp}{\value{page}}%
    \addtocounter{test@tmp}{\value{test@offset@page}}%
    \arabic{test@tmp}%
    %\thepage
  }}

\AtEndDocument{%
  \null % if by mistake a new page was started => label well defined...
  \test@set@totalpages}

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
  \test@defexpand\test@title{\test@title@change}%
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

\iftest@umons
%% UMONS logo
%%......................................................................
\newcommand\tests@FirstPage{{%
  \vspace*{-15mm}%
  \thispagestyle{firstpage}%
  \setbox0=\hbox{\includegraphics[height=15mm]{UMONS+txt}}%
  \noindent
  \vbox to\ht0{%
    \halign{##\hfil\crcr
      {\test@titlefont    \test@title}\cr
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
\iftest@correction
%% Correction of the test
%%......................................................................
\newcommand\tests@FirstPage{{%
  \vspace*{-15mm}%
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
  \vspace*{-15mm}%
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
      %&Date~: \test@date&\cr
      &Section~: \section@hook &\cr
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

\iftest@umons
%% UMONS logo
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand{\@oddhead}{{%
      \setbox0=\hbox{\includegraphics[height=11mm]{UMONS+txt}}%
      \vbox to 0pt{\vss
        \vbox to\ht0{%
          \halign to\textwidth{####\hfil \tabskip=0pt plus 1000pt&
            ####\tabskip=0pt\crcr
            {\test@smalltitlefont    \test@title}\cr
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
            {\test@smalltitlefont    \test@title}\cr
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
        &Section~: \section@hook &\cr
        height .5\test@titleskip&\omit&\cr
        \noalign{\hrule height \test@rulethickness depth 0pt}}}%
    %%
%     \vbox to 0pt{\vss
%       \noindent
%       \vbox to \ht0{%
%         \halign{####\hfil\crcr
%           \noalign{\vspace*{\test@titleskip}\vspace*{\test@rulethickness}}%
%           \test@titlefont  \test@smalltitlefont    
%           \test@title\cr
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
          {\test@smalltitlefont    \test@title}\cr
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
    \ifx \question@comment \empty Question~\arabic{test@question}.
    \else
    \make@question{Question~\arabic{test@question} \ignorespaces #1.}%
    \fi
  }%
}{%
  \par
  \iftest@correction \vspace{2ex plus 6ex}\else \vspace{4ex}\fi
}

\newenvironment{question*}{%
  \make@question{Question~\arabic{test@question} (suite).}%
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
    \rlap{\smash{\hspace*{#3}\hspace*{2.em}%
        %$\left/ \vrule height 3ex width0pt\right.$}
        \raisebox{-1.5ex}{%
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

\fi


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
    \setlength{\topsep}{0.1ex}%
    \setlength{\itemindent}{0pt}%
    \setlength{\labelwidth}{\itemindent}%
    \setlength{\labelsep}{1ex}%
    \setlength{\itemsep}{0.1ex}%
    \setlength{\leftmargin}{2.3ex}%
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

\newcommand{\testsTrueLabel}{Vrai~:}
\newcommand{\testsFalseLabel}{Faux~:}

\newcommand\tests@TF@drawbox{%
  \hbox{\vrule \vtop{\vbox{\hrule
        \hbox{\vrule width 0pt height 1.7ex depth 0.3ex\hskip 2ex}}%
      \hrule}\vrule}}

\newcounter{TrueFalse}

\def\tests@TF@number{\hbox to 1.8em{\textsf{(\alph{TrueFalse})}\hss}}

\newenvironment{TrueFalse}{\bgroup
  \def\tests@TF@label{\tests@TF@number
    \testsTrueLabel\ \tests@TF@drawbox\quad
    \testsFalseLabel\ \tests@TF@drawbox}%
  \begin{tests@TF@gen}
  }{%
  \end{tests@TF@gen}
  \egroup}

\newenvironment{TrueFalse*}{\bgroup
  \def\tests@TF@label{\tests@TF@number \drawbox}%
  \begin{tests@TF@gen}
  }{%
  \end{tests@TF@gen}
  \egroup}

\newenvironment{tests@TF@gen}{%
  \bgroup
  \ifnum\@itemdepth >\thr@@ \@toodeep   \else
    \advance\@itemdepth\@ne
    \setcounter{TrueFalse}{0}%
    \expandafter\list{%
      \addtocounter{TrueFalse}{1}%
      \gdef\@currentlabel{\alph{TrueFalse}}%
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
      \setlength{\topsep}{10.0pt plus 4.0pt minus 6.0pt}
      \setlength{\itemsep}{5.0pt plus 2.5pt minus 1.0pt}
      \def\makelabel##1{\hss \llap{##1}}%
    }%
    \fi
}{%
  \global\advance\@listdepth\m@ne \endtrivlist
  \egroup
}




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
      pdfauthor={Christophe.Troestler@umons.ac.be},
      pdfkeywords={Mathematical tests},
      pdfsubject={\test@title},
      pdfpagemode=UseNone,
      pdfstartview=FitH,
      colorlinks=true,
      urlcolor=test@darkgreen,
      citecolor=test@red,
      linkcolor=test@darkblue
    }%
    \ifx \test@datepdf\empty
    \hypersetup{%
      pdftitle={\test@thetestpdf\space (\test@title)}}%
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
