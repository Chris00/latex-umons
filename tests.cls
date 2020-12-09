\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{tests}[2000/01/04 v0.1 ^^J
  \space
  Format pour des tests et examens.]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            O P T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\iftests@want@rulers \tests@want@rulersfalse
\DeclareOption{rulers}{\tests@want@rulerstrue}

\newif\iftestscorrection \testscorrectionfalse
\DeclareOption{correction}{\testscorrectiontrue}

\newif\iftests@logo \tests@logofalse
\DeclareOption{umons}{\tests@logotrue}% (deprecated)
\DeclareOption{logo}{\tests@logotrue}% No name, UMONS logo

\newif\iftests@mps \tests@mpsfalse
\DeclareOption{mps}{\tests@mpstrue}

\newif\iftests@auto@maketitle  \tests@auto@maketitletrue
\DeclareOption{no-auto-maketitle}{\tests@auto@maketitlefalse}

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
\RequirePackage{atveryend}
\RequirePackage{translator}
\RequirePackage{ifthen}

\providetranslation[to=english]{Test no}{Test \#}
\providetranslation[to=english]{continued}{cont'd}

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
\providetranslation[to=french]{continued}{suite}

\iftests@want@rulers
\RequirePackage{color}
\fi
\iftestscorrection
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
  \newcommand{\tests@IN}{{\mathbb{N}}}
  \DeclareUnicodeCharacter{2125}{\tests@IN}% ℕ
  \newcommand{\tests@IZ}{{\mathbb{Z}}}
  \DeclareUnicodeCharacter{2124}{\tests@IZ}% ℤ
  \newcommand{\tests@IQ}{{\mathbb{Q}}}
  \DeclareUnicodeCharacter{211A}{\tests@IQ}% ℚ
  \newcommand{\tests@IR}{{\mathbb{R}}}
  \DeclareUnicodeCharacter{211D}{\tests@IR}% ℝ
  \newcommand{\tests@IC}{{\mathbb{C}}}
  \DeclareUnicodeCharacter{2102}{\tests@IC}% ℂ
}


%% Special Definitions
%%----------------------------------------------------------------------
\newcommand{\tests@sf}{\fontfamily{phv}\fontseries{m}\fontshape{n}}
\newcommand\tests@titlefont{\tests@sf      \fontsize{23}{25}\selectfont
  \def\normalsize{\@setfontsize\normalsize\@xiipt{14}}%
}
\newcommand\tests@numberfont{\tests@sf     \fontsize{17.28}{19}\selectfont}
\newcommand\tests@smalltitlefont{\tests@sf \fontsize{14}{16}\selectfont
  \def\normalsize{\@setfontsize\normalsize\@xivpt{16}}%
}
\newcommand\tests@namesfont{\tests@sf      \fontsize{12}{14}\selectfont}
\newcommand\tests@smallnamesfont{\tests@sf \fontsize{9}{14}\selectfont}

\newcommand\testscorrection{\tests@sf \color[gray]{0.6}%
  \bfseries\fontsize{30}{32}\selectfont}
\newcommand\tests@smallcorrection{\tests@sf \color[gray]{0.6}%
  \bfseries\fontsize{20}{20}\selectfont}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                             Graphics
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Add .mps as favorite to the graphics extensions:
\iftests@mps
\AtBeginDocument{%
  \DeclareGraphicsExtensions{.mps,\Gin@extensions}%
}
\fi


\def\tests@logo@file{UMONS+txt}
\newcommand{\settestlogo}[1]{\def\tests@logo@file{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                              First page
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test number and date.
%% (We hold the changes in some variables, allowing redefining them
%% and then activating the changes with \maketitle -- that allows
%% several tests to be grouped in a single file.)
\newcommand\tests@number@change{0}
\newcommand{\testnumber}[1]{\gdef\tests@number@change{#1}}
\newcommand\tests@date@change{\today}
\newcommand\tests@datepdf@change{\tests@date}
\newcommand{\testdate}{\@ifnextchar[%]
  {\testdate@pdf}{\testdate@std}}
\def\testdate@pdf[#1]#2{%
  \gdef\tests@datepdf@change{#1}%
  \gdef\tests@date@change{#2}}
\newcommand\testdate@std[1]{\testdate@pdf[{#1}]{#1}}

% Only for the PDF (use \@author as in "article")
\def\@author{Christophe.Troestler@umons.ac.be}
\newcommand{\testauthor}[1]{\gdef\@author{#1}}

\begingroup
\catcode`\:=\active
\gdef\tests@activecolon{:}% For e.g. French (or other languages)
\gdef:{\string:}% Default value of the macro
\endgroup

\newcommand{\nom@name}{%
  \translatelet{\tests@tmp}{Name}%
  \ifx \tests@tmp\empty \else \tests@tmp\tests@activecolon \fi}
\newcommand{\prenom@name}{%
  \translatelet{\tests@tmp}{Firstname}%
  \ifx \tests@tmp\empty \else \tests@tmp\tests@activecolon \fi}
\newcommand{\section@name}{%
  \translatelet{\tests@tmp}{Section}%
  \ifx \tests@tmp\empty \else \tests@tmp\tests@activecolon \fi}

\newcommand{\studentlastname}{}
\newcommand{\studentfirstname}{}

\newcommand{\testlastname}[1]{%
  \edef\tests@lastname@tmp{#1}%
  \ifx \tests@lastname@tmp\empty
    \gdef\tests@lastname@change{}% used to set \studentlastname
  \else
    \gdef\tests@lastname@change{#1}\fi}
\newcommand{\tests@display@lastname}{%
  \ifx \studentlastname\empty  \iftests@want@rulers \tests@lastname@rulers \fi
  \else \studentlastname \fi}

\newcommand{\testfirstname}[1]{%
  \edef\tests@firstname@tmp{#1}%
  \ifx \tests@firstname@tmp\empty  \gdef\tests@firstname@change{}%
  \else                            \gdef\tests@firstname@change{#1}\fi}
\newcommand{\tests@display@firstname}{%
  \ifx \studentfirstname\empty \iftests@want@rulers \tests@firstname@rulers \fi
  \else \studentfirstname \fi}

\testlastname{}% Only takes effect at \maketitle
\testfirstname{}

\newcommand{\tests@section@change}{}
\newcommand{\testsection}[1]{\gdef\tests@section@change{#1}}
\newcommand{\tests@display@section}{%
  \ifx \studentsection\empty \iftests@want@rulers \tests@section@rulers \fi
  \else \studentsection \fi}
\testsection{}

\newif\iftests@section % No “section” for students
\tests@sectiontrue % default
\def\tests@section@hook@toggle{}% To activate for the next test
\newcommand{\testsectiontrue}{%
  \def\tests@section@hook@toggle{\global\tests@sectiontrue}}
\newcommand{\testsectionfalse}{%
  \def\tests@section@hook@toggle{\global\tests@sectionfalse}}

%% If one needs to change ``Mathematique Elementaire'' to something else:
\newcommand\tests@title@change{Math\'ematique \'El\'ementaire}
\newcommand{\tests@title@firstpage@change}{\tests@title@change}
\newcommand{\testtitle}[2][]{%
  \gdef\tests@title@firstpage@change{#2}%
  \xdef\@temp{#1}%
  \ifx \@temp\empty \gdef\tests@title@change{#2}%
  \else \gdef\tests@title@change{#1}\fi}

%% `Test' title is not always right, we also want to typeset exams...
\newcommand\tests@thetests@change{\translate{Test no}\thinspace\tests@number}
\newcommand\tests@thetestpdf@change{\translate{Test} \tests@number}

\newcommand{\testtype}{%
  \@ifnextchar[{\testtype@pdf}{\testtype@equalpdf}}
\newcommand\testtype@equalpdf[1]{%
  \gdef\tests@thetests@change{#1}%
  \gdef\tests@thetestpdf@change{#1}}
\def\testtype@pdf[#1]#2{%
  \gdef\tests@thetests@change{#2}%
  \gdef\tests@thetestpdf@change{#1}}

\newcommand{\exam}{\testtype{\translate{Exam}}}
\newcommand{\cote}{\testtype{\translate{Rated exercise}}}


% If several ``independent'' tests in a single document:
\newcounter{tests@part}
\setcounter{tests@part}{0}
\newcounter{tests@offset@page}% to substract to the current page
\setcounter{tests@offset@page}{0}
\newcounter{tests@tmp}

% Hold the page offset until the new test is started:
\newcommand{\tests@offset@page@change}{0}

\AtBeginDocument{%
  \ltx@ifpackageloaded{hyperref}{%
    \newcommand{\thetotalpage}{%
      \ref*{test:totalpages-\the\c@tests@part}}%
  }{%
    \newcommand{\thetotalpage}{%
      \expandafter\ref{test:totalpages-\the\c@tests@part}}%
  }}

\newcommand{\tests@set@totalpages}{%
  % To be called AFTER the last page of the current test is outputted.
  \addtocounter{page}{-1}%
  \setcounter{tests@tmp}{\value{page}}%
  \addtocounter{tests@tmp}{\value{tests@offset@page}}%
  % Does not work after the document is closed.  Must save label by hand.
  % \edef\@currentlabel{\the\c@tests@tmp}% # of pages
  % \expandafter\label{test:totalpages-\the\c@tests@part}%
  \ltx@ifpackageloaded{hyperref}{%
    \immediate\write\@auxout{\string\newlabel{test:totalpages-\the\c@tests@part}%
      {{\the\c@tests@tmp}{\thepage}{}{}{}}}%
  }{%
    \immediate\write\@auxout{\string\newlabel{test:totalpages-\the\c@tests@part}%
      {{\the\c@tests@tmp}{\thepage}}}%
  }%
  % Change to activate at the beginning of the new test:
  \edef\tests@offset@page@change{-\the\c@page}%
  \addtocounter{page}{1}% restore the page count
}

\newcommand{\tests@thepage}{{%
    \setcounter{tests@tmp}{\value{page}}%
    \addtocounter{tests@tmp}{\value{tests@offset@page}}%
    \arabic{tests@tmp}%
    %\thepage
  }}

\AfterLastShipout{%
  \begingroup
  \tests@set@totalpages
  \endgroup}

%% Same as \def#1{#2} except that #2 is expanded _1_ level.  This is
%% specifically to "activate" the waiting changes, hold in some
%% macros.  (\edef expands too much.)
\newcommand\tests@defexpand[2]{%
  \expandafter\gdef\expandafter#1\expandafter{#2}%
}

% Whether to display a box to fill with name, first-name, section
\newif\iftests@studentbox

\newcommand{\tests@activate@changes}{%
  \addtocounter{tests@part}{1}% new test
  \typeout{-- Test \arabic{tests@part} --}%
  %% Activate the changes (expand now):
  %\message{--- Activating the changes. ---}
  \tests@defexpand\tests@number{\tests@number@change}%
  \tests@defexpand\tests@date{\tests@date@change}%
  \tests@defexpand\tests@datepdf{\tests@datepdf@change}%
  \tests@defexpand\studentlastname{\tests@lastname@change}%
  \tests@defexpand\studentfirstname{\tests@firstname@change}%
  \tests@section@hook@toggle
  \tests@defexpand\studentsection{\tests@section@change}%
  \tests@defexpand\tests@title@firstpage{\tests@title@firstpage@change}%
  \tests@defexpand\@title{\tests@title@change}%
  \tests@defexpand\tests@thetest{\tests@thetests@change}%
  \tests@defexpand\tests@thetestpdf{\tests@thetestpdf@change}%
  \setcounter{tests@offset@page}{\tests@offset@page@change}%
  % Set \iftests@studentbox according to the given data
  \tests@studentboxtrue
  \iftestscorrection
    \ifx \studentlastname\empty
      \ifx \studentfirstname\empty
        \iftests@section
          \ifx \studentsection\empty  \tests@studentboxfalse \fi
        \fi
      \fi
    \fi
  \fi
}

\newif\iftests@exists@previous@test
\tests@exists@previous@testfalse

%% \AtBeginDocument does not work because "babel" switches language
%% there and the default language may not be active when executing the
%% macros starting the initial test.
\let\tests@begindocument@orig=\document
\renewcommand{\document}{%
  \tests@begindocument@orig
  \iftests@auto@maketitle
  \tests@exists@previous@testtrue
  \tests@activate@changes
  \tests@FirstPage
  \fi}

% After \begin{document}, one may want to start another test in the 
% same file
% With a star: Same test but different course,... (merging)
% Without: ``independent'' test, optional arg to redefine
\renewcommand\maketitle{\@ifstar{\maketitle@cont}{\maketitle@new}}
\newcommand\maketitle@cont{
  \newpage
  \tests@activate@changes
  \tests@FirstPage
}

\newcommand\maketitle@new{%
  \iftests@exists@previous@test
  \null
  \newpage % make sure the last page of the previous test is outputted
  \tests@set@totalpages
  \fi
  \tests@exists@previous@testtrue % start new test
  \tests@activate@changes
  \setcounter{question}{0}%
  \setcounter{equation}{0}%
  \setcounter{footnote}{0}%
  \setcounter{figure}{0}%
  % Do not let \hyper@refstepcounter treat equations specially because
  % that generates name clashes.
  \edef\name@of@eq{no-equation}%
  \def\theHequation{\arabic{equation}-\arabic{tests@part}}%
  % Name clashes also happen for pages.  Since I do not know how to
  % avoid it, I set an offset used to display it.
  %\setcounter{page}{1}%
  \tests@FirstPage
}



\newcommand\ps@firstpage{%
  \renewcommand\@mkboth[2]{}%
  \renewcommand\@oddhead{}%
  \renewcommand\@oddfoot{\reset@font \hfil \tests@thepage/\thetotalpage}%
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot}

  
\newlength{\tests@titleskip}    \setlength{\tests@titleskip}{6pt}
\newlength{\tests@rulethickness}\setlength{\tests@rulethickness}{0.5pt}
\newcommand\tests@beforetext{3ex}

\newcommand{\tests@FirstPage@studentbox}{%
  % Box for `nom',... to fill
  \tests@namesfont
  \offinterlineskip
  \halign to 55mm{\vrule width \tests@rulethickness ##&
      \strut \ ##\hfil\tabskip 0pt plus 1000pt&
      \vrule width \tests@rulethickness ##\tabskip 0pt\crcr
    \noalign{\hrule height \tests@rulethickness depth 0pt}
    \iftests@section  height \tests@titleskip&\omit&\cr %% extra vspace
    \else             height 1.5\tests@titleskip&\omit&\cr \fi
    &\nom@name \rlap{\ \tests@display@lastname}&\cr
    \iftests@section  height \tests@titleskip&\omit&\cr
    \else             height 1.5\tests@titleskip&\omit&\cr  \fi
    &\prenom@name \rlap{\ \tests@display@firstname}&\cr
    height \tests@titleskip&\omit&\cr
    \iftests@section
      &\section@name \rlap{\ \tests@display@section}&\cr
      height .5\tests@titleskip&\omit&\cr
    \fi
    \noalign{\hrule  height \tests@rulethickness depth 0pt}}}

\iftests@logo
%% UMONS logo
%%......................................................................
\newcommand\tests@FirstPage{{%
  \vspace*{-19mm}%
  \thispagestyle{firstpage}%
  \setbox0=\hbox{\includegraphics[height=15mm]{\tests@logo@file}}%
  \noindent
  \vbox to\ht0{%
    \halign{##\hfil\crcr
      {\tests@titlefont    \tests@title@firstpage}\cr
      \noalign{\vfill}
      \tests@numberfont   \tests@thetest %% Test n°...
      \ifx\tests@date\empty \else  
      \qquad \hfill \tests@namesfont (\tests@date)\fi
      {\tests@namesfont\strut}% make sure you get the correct depth
      \cr
    }}%
  \hfill \kern 3mm
  \box 0
  \vspace*{6pt}\hrule height 2\tests@rulethickness
  \par\vspace*{\tests@beforetext}}}

\else
%% Test or its correction
%%......................................................................

\newcommand\tests@FirstPage{{%
  \iftests@studentbox\vspace*{-25mm}\else\vspace*{-22mm}\fi
  \thispagestyle{firstpage}%
  \iftests@studentbox \setbox0=\vbox{\tests@FirstPage@studentbox}
  \else \setbox0=\hbox{{\testscorrection
      \rotatebox{10}{\translate{Correction}}}}\fi
  %
  \noindent
  \vbox to \ht0{%
    \halign{##\hfil\crcr
      \iftests@studentbox
        \noalign{\vskip\tests@titleskip \vspace*{\tests@rulethickness}}\fi
      {\tests@titlefont    \tests@title@firstpage}\cr
      \noalign{\vfill}
      \tests@numberfont   \tests@thetest %% Test n°...
      {\tests@namesfont\strut % make sure you get the correct depth
        \ifx\tests@date\empty \else \qquad \hfill (\tests@date)\fi
      }%
      \cr
      \iftests@studentbox
      \noalign{%
        \iftests@section \vskip.5\tests@titleskip \fi
        \vspace*{\tests@rulethickness}}%
      \fi}}%
  \hfill
  \iftests@studentbox \iftestscorrection % Correction written underneath box
  \rlap{\smash{\testscorrection\color[gray]{0.85}%
      \rotatebox{\iftests@section 17\else 13\fi}{\translate{Correction}}}}%
  \fi \fi
  \box0
  \vspace*{6pt}\hrule height 2\tests@rulethickness
  \par\vspace*{\tests@beforetext}}}

\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                        O T H E R    P A G E S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\tests@studentbox}{%
  \multiply\tests@rulethickness by2
  \tests@namesfont
  \offinterlineskip
  \halign to 55mm{\vrule width \tests@rulethickness ##&
      \strut \ ##\hfil\tabskip 0pt plus 1000pt&
      \vrule width \tests@rulethickness ##\tabskip 0pt\crcr
    \noalign{\hrule height \tests@rulethickness depth 0pt}%
    \iftests@section
      height \tests@titleskip&\omit&\cr %% extra vspace
    \else
      height 1.3\tests@titleskip&\omit&\cr
    \fi
    &\nom@name \rlap{\ \tests@display@lastname}&\cr
    \iftests@section
      height \tests@titleskip&\omit&\cr
    \else
      height 1.5\tests@titleskip&\omit&\cr
    \fi
    &\prenom@name \rlap{\ \tests@display@firstname}&\cr
    \iftests@section
      height \tests@titleskip&\omit&\cr
      &\section@name \rlap{\ \tests@display@section}&\cr
      height 0.5\tests@titleskip&\omit&\cr
    \else
      height 0.7\tests@titleskip&\omit&\cr
    \fi
    \noalign{\hrule height \tests@rulethickness depth 0pt}}}

\iftests@logo
%% UMONS logo
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand{\@oddhead}{{%
      \setbox0=\hbox{\includegraphics[height=11mm]{\tests@logo@file}}%
      \vbox to 0pt{\vss
        \vbox to\ht0{%
          \halign to\textwidth{####\hfil \tabskip=0pt plus 1000pt&
            ####\tabskip=0pt\crcr
            {\tests@smalltitlefont    \@title}\cr
            \noalign{\vfill}%
            \tests@namesfont\strut   \tests@thetest %% Test n°...
            \ifx\tests@date\empty \else  \qquad \hfill
            \tests@smallnamesfont (\tests@date)\fi
            &\smash{\box 0}\cr
          }}%
        \vspace*{.5\tests@titleskip}
        \hrule height 2\tests@rulethickness width\hsize
      }}}%
  \renewcommand\@oddfoot{\reset@font \hfil \tests@thepage/\thetotalpage}%
  \let\@evenhead\@empty 
  \let\@evenfoot\@oddfoot}

\else
\iftestscorrection
%% Correction of the test
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand\@oddhead{{%
      \setbox0=\hbox{{\tests@smallcorrection
          \rotatebox{10}{\translate{Correction}}}}%
      \vbox to 0pt{\vss
        \vbox to\ht0{%
          \halign to\textwidth{####\hfil \tabskip=0pt plus 1000pt&
            ####\tabskip=0pt\crcr
            {\tests@smalltitlefont    \@title}\cr
            \noalign{\vfill}%
            \tests@namesfont\strut   \tests@thetest %% Test n°...
            \ifx\tests@date\empty \else  \qquad \hfill
            \tests@smallnamesfont (\tests@date)\fi
            &\smash{\box 0}\cr
          }}%
        \vspace*{.5\tests@titleskip}
        \hrule height 2\tests@rulethickness width\hsize
      }}}%
  \renewcommand\@oddfoot{\reset@font \hfil \tests@thepage/\thetotalpage}%
  \let\@evenhead\@empty 
  \let\@evenfoot\@oddfoot}

\else
%% Test (not correction)
%%......................................................................
\newcommand\ps@test{%
  \let\@mkboth\@gobbletwo 
  \renewcommand\@oddhead{{%
    \setbox0=\vbox{\tests@studentbox}%
    \vbox to 0pt{\vss
      \noindent
      \setlength{\@tempdima}{\textwidth}%
      \addtolength{\@tempdima}{-\wd0}%
      \vtop{\hsize=\@tempdima  \addtolength{\baselineskip}{20pt}%
        \halign{####\hfil\crcr
          \noalign{\vspace*{\tests@titleskip}\vspace*{\tests@rulethickness}}%
          {\tests@smalltitlefont    \@title}\cr
          \noalign{\vfill}%
          \tests@namesfont\strut   \tests@thetest %% Test n°...
          \ifx\tests@date\empty \else  \qquad \hfill
          \tests@smallnamesfont (\tests@date)\fi
          \cr
          \noalign{\vspace*{.5\tests@titleskip}}
          }%
        \par\hrule height 2\tests@rulethickness width\hsize
        }%
      \hfill 
      \smash{\vtop{\unvbox0}}\par
      \hrule height 0pt depth 0pt %% This is the \vbox baseline...
      }%
    }}%
  \renewcommand\@oddfoot{\reset@font \hfil \tests@thepage/\thetotalpage}%
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

\iftests@want@rulers

\newcommand\tests@lastname@rulers{\bgroup
  \color[gray]{0.5}%
  \hspace{3pt}%
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \tests@onechar\tests@onechar
  \egroup}

\newcommand\tests@firstname@rulers{\bgroup
  \color[gray]{0.5}%
  \hspace{3pt}%
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \tests@onechar\tests@onechar\tests@onechar\tests@onechar\tests@onechar
  \egroup}

\newcommand{\tests@section@rulers}{{%
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
  \vspace*{-\tests@beforetext}\vspace*{6pt}%
  \begin{quote}
    \small
  }{%
  \end{quote}
  \vspace*{2pt}  \hrule height 1pt
  \vspace*{\tests@beforetext}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                            P A R T S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% L'examen d'Analyse comporte deux parties (2 cours).
\renewcommand{\part}[1]{%
  \par
  \colorbox[gray]{.8}{\begin{minipage}{0.985\linewidth}\centering%
      \vrule height 2.2ex width 0pt depth 0.2ex
      #1\relax
      \vrule height 2.2ex width 0pt depth 0.2ex
    \end{minipage}}%
  \par\medskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                          Q U E S T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{question}
\setcounter{question}{0}

% Save the default \linewidth (useful if the question is inside a
% minipage with its local \linewidth).
\newlength{\question@linewidth}
\AtBeginDocument{\setlength{\question@linewidth}{\linewidth}}

\newcommand{\question@with@number}{%
  \edef\question@number{\thequestion}%
  \ifx \question@number \empty \translate{Question}%
  \else \translate{Question}~\thequestion \fi
}

%% Optional [comment]
%% Optional <mark>
\newenvironment{question}[1][]{%
  \stepcounter{question}%
  \edef\question@comment{#1}%
  \make@question{%
    \ifx \question@comment \empty \question@with@number.
    \else \question@with@number \ \ignorespaces #1.%
    \fi
  }%
}{%
  \par
  \iftestscorrection \vskip 2ex plus 1\jot
  \else \vspace{4ex}\fi
  \pagebreak[2]% Very good place to break pages
}

\newenvironment{question*}{%
  \make@question{\question@with@number\ (\translate{continued}).}%
}{%
  \par
  \iftestscorrection \vskip 2ex plus 1\jot
  \else \vspace{4ex}\fi
  \pagebreak[2]%
}

\newcommand{\make@question}[1]{%
  \@ifnextchar<{\make@question@withmark{#1}}{\make@question@{#1}}}

\def\make@question@withmark#1<#2>{%
  \@ifnextchar[{\make@question@withmarkdist{#1}{#2}}{%
    \make@question@withmarkdist{#1}{#2}[\question@linewidth]}}

%% Display mark for the question
\def\make@question@withmarkdist#1#2[#3]{%
  \iftestscorrection\else
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
  \gdef\@currentlabel{\thequestion}%
  \iftestscorrection \vspace{3ex plus 3ex minus 1ex}\pagebreak[2]\fi
  \noindent\textsf{#1}\quad
  \iftestscorrection \itshape \else \upshape\fi
  \ignorespaces
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                       C O R R E C T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\iftestscorrection

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
% Not a correction, hide answers.
\newbox\tests@answer

\newenvironment{answer}{%
  % The verbatim \comment ... \endcomment does not play well with the
  % “namequestion” environment.
  \setbox\tests@answer=\vbox\bgroup
}{%
  \egroup
}
\newcommand{\inlineanswer}[1]{}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%                   N A M E   Q U E S T I O N S
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\namedquestion}[2]{% <name> <number>
  \@ifundefined{tests@named@#1@#2} {%
    \@ifundefined{c@tests@named@#1}{%
      \ClassError{tests}{Named question `#1' doesn't exist}{}%
    }{%
      \ClassError{tests}{%
        Number `#2' of named question `#1' doesn't exist.^^J\space\space%
        Possible values are 1..\the\value{tests@named@#1}}{%
        Change the number in \string\namedquestion{#1}{#2}^^J%
        so that it is in the range 1..\the\value{tests@named@#1}.}}}{%
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
      \ClassError{tests}{Option `separator' only accepts `comma' and %
        `semicolon' as values.}{}}}}

% Expands a CSV line and scans content
\def\tests@CSV@escanline#1{%
  \toks@\expandafter{#1}%
  \edef\tests@@CSV@scanline{\noexpand\tests@CSV@scanline{\the\toks@}}%
  \tests@@CSV@scanline%
  \xdef\tests@CSV@columncount{\thetests@CSVcol}% = number of cols
}

% #1 is the header name.  This macro apply \macro to
% \tests@CSVcol⟨number⟩ (which contains the cell content).  It is
% supposed to be used after a line has been scanned with
% \tests@CSV@escanline.  A missing name is the same as an empty cell.
\def\tests@CSV@apply#1#2{% ⟨\macro⟩ ⟨header name⟩
  \@ifundefined{tests@CSVcolofname@#2}{}{%
    \edef\tests@CSV@numcol{\csname tests@CSVnumcolofname@#2\endcsname}%
    \ifnum\tests@CSV@numcol >\tests@CSV@columncount \else
      \edef\tests@CSV@column{\csname tests@CSVcolofname@#2\endcsname}%
      \expandafter\let\expandafter\tests@CSV@content
          \csname\tests@CSV@column\endcsname
      \expandafter#1\expandafter{\tests@CSV@content}%
    \fi
  }}

% Expand to the content of the column named #1.  This command will
% be accessible as \CSV in questions used in \generatetestsfromCSV.
\def\tests@CSV@valueofcol#1{% ⟨header name⟩
  % Supposed to be used after a line has been scanned with
  % \tests@CSV@escanline.
  \@ifundefined{tests@CSVcolofname@#1}{%
    \ClassError{tests}{No column named `#1' exists in the %
      file `\tests@CSV@input@filename'.}{}%
  }{%
    \edef\tests@CSV@numcol{\csname tests@CSVnumcolofname@#1\endcsname}%
    \ifnum\tests@CSV@numcol >\tests@CSV@columncount
      % The author expects to see a value; issue an warning.
      \ClassWarning{tests}{Column named `#1' is not filled in the %
        file `\tests@CSV@input@filename'}%
    \else
      \edef\tests@CSV@column{\csname tests@CSVcolofname@#1\endcsname}%
      \expandafter\let\expandafter\tests@CSV@content
          \csname\tests@CSV@column\endcsname
      \tests@CSV@content
    \fi}}

\newread\tests@CSV@file

\let\tests@CSV@par=\par
\def\tests@CSV@readline{{% In a group
    \catcode`\$=12%
    \catcode`\#=12%
    \catcode`\~=12%
    \catcode`\%=12%
    \catcode`\&=12%
    %\catcode`\\=12% allow interpretation of TeX sequences for \CSV
    \catcode`\_=12%
    \catcode`\^=12%
    %\catcode`\{=12%
    %\catcode`\}=12%
    \global\read\tests@CSV@file to\tests@CSVline}}

\def\tests@CSV@processheadline{%
  \tests@CSV@readline
  \if\tests@CSV@par\tests@CSVline\relax
    \ClassError{tests}{%
      File `\tests@CSV@input@filename' starts with an empty line!}{}%
  \fi
  \tests@CSV@escanline{\tests@CSVline}%
  \global\c@tests@CSVcol 0\relax
  \loop
    \global\advance\c@tests@CSVcol 1\relax
    % Expand \tests@CSVcolofname@⟨header⟩ into tests@CSVcol⟨number⟩
    \edef\tests@CSV@column{tests@CSVcol\romannumeral\c@tests@CSVcol}%
    \edef\tests@CSV@header{\csname\tests@CSV@column\endcsname}%
    \edef\tests@CSV@destname{%
      \csname tests@CSVcolofname@\tests@CSV@header\endcsname}%
    \expandafter\expandafter\expandafter
    \gdef\expandafter\tests@CSV@destname\expandafter{\tests@CSV@column}%
    % Expand \tests@CSVcolofname@⟨header⟩ into ⟨number⟩
    \edef\tests@CSV@destname{%
      \csname tests@CSVnumcolofname@\tests@CSV@header\endcsname}%
    \expandafter\xdef\tests@CSV@destname{\the\c@tests@CSVcol}%
  \ifnum\c@tests@CSVcol<\tests@CSV@columncount\repeat
}

\def\tests@CSV@loop@questions#1,{%
  \ifx\relax#1\@empty \else
  \KV@@sp@def\@tempa{#1}% Name of the question given in \generatetestsfromCSV
  \def\tests@CSV@question##1{% ##1 = content of CSV cell
    % Only display the question if the cell is not empty.
    \def\@tempb{##1}%
    \ifx\@tempb\empty \relax \else \namedquestion{\@tempa}{##1}\fi
  }%
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
    \ClassError{tests}{File `\tests@CSV@input@filename' not existent, %
      not readable, or empty!}{}%
  \else
    % Expand the questions so they can contain macros (useful for
    % factor out lists of questions).
    \edef\tests@CSV@questions{#3}%
    \let\tests@CSV@save=\CSV
    \let\CSV=\tests@CSV@valueofcol
    \tests@CSV@processheadline
    % Loop over other lines
    \gdef\tests@CSV@loop{%
      \ifeof\tests@CSV@file
        \global\let\tests@CSV@next=\relax
      \else
        \global\let\tests@CSV@next=\tests@CSV@loop
        \tests@CSV@readline
        \if\tests@CSV@par\tests@CSVline \else
          \tests@CSV@escanline{\tests@CSVline}%
          % Generate a new test from the data
          \tests@CSV@apply\testlastname{Nom}%
          \tests@CSV@apply\testfirstname{Prenom}%
          \tests@CSV@apply\testsection{Section}%
          \maketitle
          \expandafter\tests@CSV@loop@questions \tests@CSV@questions,\relax,%
        \fi
      \fi
      \tests@CSV@next}%
    \tests@CSV@loop
    \let\CSV=\tests@CSV@save % restore possibly old def
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
\renewcommand{\p@enumii}{\theenumi .}% label prefix

\renewcommand{\theenumiii}{\Alph{enumiii}}
\renewcommand{\labelenumiii}{(\theenumiii)}
\renewcommand{\p@enumiii}{\p@enumii .}

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

\newcommand{\testsTrueLabel}{\translate{True}\tests@activecolon}
\newcommand{\testsFalseLabel}{\translate{False}\tests@activecolon}

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
    \newcommand{\teststick}{\ding{52}}%
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
    \definecolor{tests@green}{rgb}{0.56862745,0.78039216,0.63137255}% #91c7a1
    \definecolor{tests@darkgreen}{rgb}{0.4,0.47,0.42}% #667a6a
    \definecolor{tests@blue}{rgb}{0.23,0.85,0.98}% #3ad9fc
    \definecolor{tests@darkblue}{rgb}{0.23,0.33,0.95}%
    \definecolor{tests@metalblue}{rgb}{0.21,0.67,0.61}%
    \definecolor{tests@red}{rgb}{0.67,0.03,0.06}%
    \tests@activate@changes % Apply settings from the preamble
    \hypersetup{%
      %% Changes (to \tests@thetestpdf,...) must have been applied.
      pdfauthor={\@author},
      pdfkeywords={Mathematical tests},
      pdfsubject={\@title},
      pdfpagemode=UseNone,
      pdfstartview=FitH,
      colorlinks=true,
      urlcolor=tests@darkgreen,
      citecolor=tests@red,
      linkcolor=tests@darkblue
    }%
    \ifx \tests@datepdf\empty
    \hypersetup{%
      pdftitle={\tests@thetestpdf\space (\@title)}}%
    \else
    \hypersetup{%
      pdftitle={\tests@thetestpdf\space (\tests@datepdf)}}%
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
