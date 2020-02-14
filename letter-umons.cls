% Licence: GPL v3

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{letter-umons}[2013/02/22 v1 letter-umons document class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@letterumons@Afourpaper  \@letterumons@Afourpaperfalse
\DeclareOption{a4paper}{%
  \@letterumons@Afourpapertrue
  \PassOptionsToClass{a4paper}{letter}}

\newif\if@letterumons@uspaper  \@letterumons@uspaperfalse
\DeclareOption{uspaper}{% = letter paper = U.S. default size
  \@letterumons@uspapertrue
  \PassOptionsToClass{letterpaper}{letter}}

% TODO: Option "print" to disable the colors for the
\newif\ifumons@print \umons@printfalse
\DeclareOption{print}{\umons@printtrue}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{letter}
  }

\PassOptionsToClass{11pt}{letter}

\ProcessOptions
\LoadClass{letter}

\RequirePackage{ifthen}
\RequirePackage{graphicx,xcolor}
\RequirePackage{times,mathptmx}
\RequirePackage{translator,xspace}

\definecolor{umonsgreen}{rgb}{0.56862745,0.78039216,0.63137255}
\definecolor{umonsdarkgreen}{rgb}{0.4,0.47,0.42}
\definecolor{umonsblue}{rgb}{0.23,0.85,0.98}
\definecolor{umonsdarkblue}{rgb}{0.23,0.33,0.95}
\definecolor{umonsmetalblue}{rgb}{0.21,0.67,0.61}

\definecolor{umons-red}{cmyk}{0., 1., 0.6, 0.2}
\definecolor{umons-gray}{cmyk}{0, 0, 0, 0.5}
\definecolor{umons-turquoise}{cmyk}{0.9, 0., 0.2, 0.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                              P D F
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \@ifundefined{hypersetup}{}{%
    \hypersetup{%
      pdftitle={UMONS letter},%
      plainpages=false, % => page.i <> page.1
      colorlinks=true,
      pdfstartview=FitH,
      pdfmenubar=false
    }%
    \ifumons@print
    \hypersetup{%
      urlcolor=black,
      citecolor=black,
      linkcolor=black,
    }%
    \else
    \hypersetup{%
      urlcolor=umonsdarkgreen,
      citecolor=umonsdarkblue,
      linkcolor=umons-red,
    }%
    \fi
  }}

\newif\ifpdf@umons
\@ifundefined{pdfoutput}{%
  \pdf@umonsfalse
}{%
  \ifnum\pdfoutput<1 % => not generating pdf
    \pdf@umonsfalse
  \else
    \pdf@umonstrue
  \fi
}

\ifpdf@umons\else
\providecommand{\Hy@colorlink}[1]{}
\providecommand{\Hy@endcolorlink}{}
\fi

\AtBeginDocument{\providecommand{\texorpdfstring}[2]{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Translations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providetranslation[to=french]{Your ref.}{V/r\'ef.}
\providetranslation[to=french]{Our ref.}{N/r\'ef.}
\providetranslation[to=french]{Concerns}{Concerne}

\providetranslation[to=german]{Your ref.}{Ihr Zeichen}
\providetranslation[to=german]{Our ref.}{Zeichen}
\providetranslation[to=german]{Concerns}{Betrifft}

\providetranslation[to=italian]{Your ref.}{S/ref.}
\providetranslation[to=italian]{Our ref.}{N/ref.}
\providetranslation[to=italian]{Concerns}{Concerne}

\providetranslation[to=spanish]{Your ref.}{Us/ref.}
\providetranslation[to=spanish]{Our ref.}{Ns/ref.}
\providetranslation[to=spanish]{Concerns}{Concerniente}


\AtBeginDocument{\providecommand{\bbl@afterfi}[1]{#1}}

\newcommand{\letterumons@iflanguage}[3]{% <language> <then> <else>
  \@ifundefined{l@#1}{%
    %% language not defined, do the <else> part.
    #3\relax
  }{%
    \iflanguage{#1}{#2}{#3}%
  }}

\newcommand{\letterumons@set@date}[2]{%
  \letterumons@iflanguage{francais}{\gdef\letterumons@date{#1, le~#2}}{%
    \letterumons@iflanguage{german}{\gdef\letterumons@date{#1, den~#2}}{%
      \letterumons@iflanguage{italian}{\gdef\letterumons@date{#1, il~#2}}{%
        \letterumons@iflanguage{spanish}{\gdef\letterumons@date{#1, #2}}{%
          \letterumons@iflanguage{english}{\gdef\letterumons@date{#2}}{%
            \gdef\letterumons@date{#1, #2}% (no language specified)
          }}}}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Main part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Paper size
%%----------------------------------------------------------------------

\if@letterumons@Afourpaper
% \paperheight=297mm   \paperwidth=210mm
\typeout{letter-umons\string: Option `a4paper' modified.}

%% Set everything in true... so it resists to \mag
\setlength{\topmargin}{25truemm} \addtolength{\topmargin}{-1truein}
\setlength{\headsep}{20truept}
\setlength{\textheight}{235truemm}
%\setlength{\headheight}{0.0cm}
%\setlength{\footskip}{0.0cm}

\setlength{\oddsidemargin}{60truemm} \addtolength{\oddsidemargin}{-1truein}
\setlength{\textwidth}{14truecm}
\setlength{\marginparwidth}{20truemm}
\setlength{\evensidemargin}{\oddsidemargin}
%\setlength{\marginparsep}{0.0truecm}
\fi

\if@letterumons@uspaper
%\paperwidth=8.5truein \paperheight=11truein
\typeout{letter-umons\string: Option `uspaper' selected.}

\setlength{\voffset}{1.5truecm}  \addtolength{\voffset}{-1truein}
\setlength{\topmargin}{5truemm}
\setlength{\headsep}{20truept}
\setlength{\textheight}{222truemm}
%\setlength{\headheight}{0cm}
%\setlength{\footskip}{0cm}

\setlength{\hoffset}{2truecm}    \addtolength{\hoffset}{-1truein}
\setlength{\oddsidemargin}{5truemm}
\setlength{\textwidth}{16.5truecm}
\setlength{\marginparwidth}{20truemm}
%\setlength{\evensidemargin}{0truecm}
%\setlength{\marginparsep}{0truecm}
\fi

\setlength{\parskip}{1.6ex plus 0.5ex minus 0.2ex}

% ----------------------------------------------------------------------
%                Macros for the writer to set/change
%            references, subject, and date of the letter
% ----------------------------------------------------------------------

\def\letterumons@email{}
\newcommand{\email}[1]{\gdef\letterumons@email{#1}}

\def\letterumons@department{D\'epartement de Math\'ematique}
\newcommand{\department}[1]{\gdef\letterumons@department{#1}}

\def\letterumons@web{http\string://math.umons.ac.be}
\newcommand{\web}[1]{\gdef\letterumons@web{#1}}

\def\letterumons@phone{+32(0)65 37 33 01-02-03}
\newcommand{\phone}[1]{\gdef\letterumons@phone{#1}}

\def\letterumons@fax{+32(0)65 37 33 18}
\newcommand{\fax}[1]{\gdef\letterumons@fax{#1}}


\def\yourref{\@ifnextchar[{\yourref@}{%
    \yourref@[\translate{Your ref.}\xspace :~]}}
\def\yourref@[#1]#2{% \yourref@[<intro>]{<text>}
  \gdef\letterumons@yourref{%
    {\setbox0=\hbox{\textit{#1\/}}%
      \hangindent=\wd0 \hangafter1
      \def\\{\hfil\penalty-10000}%
      \noindent\copy0
      #2\par
    }}}

\def\ourref{\@ifnextchar[{\ourref@}{%
    \ourref@[\translate{Our ref.}\xspace :~]}}
\def\ourref@[#1]#2{\gdef\letterumons@ourref{{\textit{#1\/}#2}}}


\def\subject{\@ifnextchar[{\subject@}{%
    \subject@[\translate{Concerns}\xspace :~]}}
\def\subject@[#1]#2{\gdef\letterumons@subject{{\textbf{#1}#2}}}


% \date{<date>} or \date[<country>]{} or \date[]{<date-like>}
\renewcommand{\date}[2][Mons]{%
  \def\next{#2}%
  \ifx\next\@empty %--- so you benefit autom. date :
    \letterumons@set@date{#1}{\today}%
  \else \def\next{#1}%
    \ifx\next\@empty  \gdef\letterumons@date{#2}%
    \else             \letterumons@set@date{#1}{#2}%
    \fi
  \fi
}

\AtBeginDocument{\letterumons@set@date{Mons}{\today}}


%% Redefining \begin{letter} to include default choices
%%----------------------------------------------------------------------

\let\letterumons@letter=\letter
%% this command expects that the argument #1 is of the type
%  <name>\\<address> , both concerning the addressee.
%  It is the job of \@processto#1 in \letter to
%  \def\toname{<name>}  and \def\toaddress{<address>}
%      ~~~~~~~                  ~~~~~~~~~~ (the <address> part can be empty)
%  No typesetting is done, it is deferred till \opening
%
\long\def\letter#1{% (letter was a long def)
  %--- Set to \@empty the references and the subject
  \let\letterumons@yourref=\@empty
  \let\letterumons@ourref=\@empty
  \let\letterumons@subject=\@empty
  \letterumons@letter{#1}}


%% Defining the \thispagestyle{firstpage}
%%----------------------------------------------------------------------

\renewcommand{\ps@firstpage}{%
  \renewcommand{\@oddhead}{\vbox{%\hrule height 3pt
      \parindent=0pt \parskip=0pt % => indep of a setting outside envir.
      \noindent
      \smash{\rlap{\letterumons@logo}}%
      \smash{\rlap{\letterumons@addressee@address}}%
      \smash{\rlap{\letterumons@folding@line}}%
      \smash{\letterumons@address@left}%
    }\hfil}%--- the 3 are independent of each other
  \renewcommand{\@oddfoot}{\vtop to0pt{%\hrule height 3pt
      \vspace{5mm}%
      \hfill
      \smash{\includegraphics[height=11mm]{Pole-Hainuyer-gris}%
        %\hspace{3mm}%
        %\includegraphics[height=11mm]{academie-gris}%
      }%
      \vss}}
}

\newcommand{\ps@letter}{%
  \renewcommand{\@oddhead}{\vbox{%\hrule height 3pt
      \parindent=0pt \parskip=0pt % => indep of a setting outside envir.
      \noindent
      \smash{\rlap{\letterumons@logo}}%
    }\hfill}%
}

\pagestyle{letter}

\newcommand{\letterumons@folding@line}{%
  %% --- go to the left upper corner
  \advance\headheight by\topmargin
  \advance\headheight by\voffset     \advance\headheight by1in
  \vbox to\headheight{\kern.33333333\paperheight
    \hbox{\hskip-\oddsidemargin  \hskip-\hoffset  \hskip-1in
      \vrule width8truemm height.2truept \hfil }\vss}}


\newcommand{\letterumons@logo}{%
  \advance\headheight by\topmargin
  \advance\headheight by\voffset     \advance\headheight by1in
  \vbox to\headheight{%
    \vspace*{7mm}%
    \hfill \includegraphics[width=45mm]{UMONS}\vss}%
}

%% \letterumons@address@left
%%----------------------------------------------------------------------

% Default, if not given in the letter
\renewcommand{\fromaddress}{%
  \letterumons@department\\
  Place du Parc, 20\\
  B-7000 Mons\\
  t\'el \letterumons@phone\\
  fax \letterumons@fax\\
  \ifthenelse{\equal{\letterumons@email}{}}{%
    math@umons.ac.be}{\letterumons@email}\\
  \letterumons@web\\[3mm]
  \includegraphics[height=10mm]{UMONS_FS}%
}

\newcommand{\letterumons@address@left}{%
  \advance\headheight by\topmargin
  \advance\headheight by\voffset     \advance\headheight by1in
  \vbox to\headheight{%
    \vspace*{38mm}%
    \hspace*{-1truein}\hspace*{-\oddsidemargin}%
    \begin{minipage}[t]{55mm}
      \raggedleft
      \sffamily
      \color{umons-gray}%
      {\fontsize{15pt}{24pt}\selectfont   Universit\'e de Mons}
      \par
      \vspace*{5mm}%
      \noindent
      \textcolor{umons-red}{%
        \fontsize{10pt}{14pt}\selectfont \bfseries
        \ifthenelse{\equal{\fromname}{}}{Facult\'e des Sciences}{%
          \fromname}}%
      \par
      \vspace*{3mm}%
      \fontsize{7pt}{10pt}\selectfont
      \fromaddress
    \end{minipage}
    \vss}}

%% \letterumons@addressee@address
%%----------------------------------------------------------------------

\newlength{\WidthEnvelopeWindow}
\WidthEnvelopeWindow=70truemm         %--- set for A4 paper size.

\newlength{\DistanceLeftEnvelopeWindow}
\DistanceLeftEnvelopeWindow=115truemm %--- distance of the envelope window
                                  %    to the left of the paper
\newlength{\OverlapEnvelopeWindow}
         % overlapping of the reciever address on the body of the page

% REMARK: the 3 above quantities are also used in \closing

\newlength{\DistanceTopEnvelopeWindow}
\DistanceTopEnvelopeWindow=36truemm %--- distance of the letter window
                                    %    to the top of the paper
\newlength{\HeightEnvelopeWindow}
\HeightEnvelopeWindow=44truemm %--- total height of envelope window

\newbox\to@ddressBOX
\newlength{\letterumons@Work@length}% (local)

\newcommand{\letterumons@precompute@address}{%
  % --- Reciver address -> \to@ddressBOX
  %% This is necessary, because we need \OverlapEnvelopeWindow
  % to start the letter (see \opening)
  \setbox\to@ddressBOX=\vbox{%
      \hsize=\WidthEnvelopeWindow
      \normalsize \upshape
      \normalbaselines \parindent=0pt \parskip=0pt % (locally)
      \let\\=\par  %--- If we keep the LaTeX def., we get an underfull!!
      \parskip0pt
      % \ignorespaces is present in \toname
      \toname\\    %--- supposed to contain the addressee's name
      \toaddress   %--- supposed to contain the addressee's address
      }%
   %\showthe\ht\to@ddressBOX
   \ifdim\ht\to@ddressBOX>\HeightEnvelopeWindow
      \typeout{WARNING (letter-umons): Reciever's address too high.}
      \typeout{====================================================}\fi
   %--- compute \OverlapEnvelopeWindow
   \letterumons@Work@length=\DistanceTopEnvelopeWindow
   \ifdim\ht\to@ddressBOX < \HeightEnvelopeWindow
       \advance\letterumons@Work@length by.5\HeightEnvelopeWindow
       \advance\letterumons@Work@length by.5\ht\to@ddressBOX
     \else
       \advance\letterumons@Work@length by\ht\to@ddressBOX
     \fi
   \advance\letterumons@Work@length by-1in
   \advance\letterumons@Work@length by-\voffset
   \advance\letterumons@Work@length by-\topmargin
   \advance\letterumons@Work@length by-\headheight
   \advance\letterumons@Work@length by-\headsep
   \ifdim \letterumons@Work@length<0  \letterumons@Work@length=0 \fi
   \global\OverlapEnvelopeWindow=\letterumons@Work@length
   %\showthe\OverlapEnvelopeWindow
   }

\newcommand{\letterumons@addressee@address}{%
  {%--- typesetting the reciever address
   % Smashing box
   \vbox to0pt{\vss
      \advance\headheight by\topmargin % (locally)
      \advance\headheight by\voffset     \advance\headheight by1in
      \hbox to\textwidth{%
        \hskip-\oddsidemargin  \hskip-\hoffset  \hskip-1in
        \hskip\DistanceLeftEnvelopeWindow
        \vbox to\headheight{%
          \kern\DistanceTopEnvelopeWindow
          \vbox to\HeightEnvelopeWindow{% window of the envelope
                                        % in which the address is centered
            % \hrule
            \vskip0pt plus1000pt minus0pt % not up the window
            \box\to@ddressBOX
            \vskip0pt plus1000pt minus1000pt
            % the address can go under the window
            % \hrule
          }
          \vss}%
        \hss}%--- \hbox
    }%
  }}




%% \opening the letter
%%----------------------------------------------------------------------

% The purpose of \opening was to detect whether \fromaddress (encoded with
% \address) is empty or not, then respectively use \thispagestyle{firstpage}
% to print down below \fromlocation and \telephonenum, or print the
% \fromaddress.
% Then the date, \toname, \toaddress, and the opening argument are
% typeseted.
%
% HERE this way of doing is inadequate for we don't care about \fromaddress.
% Moreover we want to use the \thispagestyle{firstpage} facility.

\renewcommand{\opening}[1]{%
  %--- first of all, we have to set the logo and the addresses
  \letterumons@precompute@address
                  %: this is necessary to know \OverlapEnvelopeWindow
  \thispagestyle{firstpage}%
  %--- next, go for references, date, concern.
  %\hrule\vfill
  \vspace*{10mm plus 1\baselineskip minus 2\baselineskip}%
  %\showthe\OverlapEnvelopeWindow
  \vskip\OverlapEnvelopeWindow
  \leavevmode
  \vtop{%
    \hsize=.5\textwidth
    \raggedright
    \ifthenelse{\equal{\letterumons@yourref}{}}{}{%
      \letterumons@yourref \par}%
    \letterumons@ourref}%
  \noindent\hfill \letterumons@date
  \par
  \ifthenelse{\equal{\letterumons@subject}{}}{}{%
    \vspace{2\parskip plus 1\parskip minus 1\parskip}%
    \letterumons@subject\par
  }%
  %--- and eventually, open the letter !
  \vspace{3\baselineskip plus 1\baselineskip minus 2\baselineskip}%
  \ifthenelse{\equal{#1}{}}{}{%
    #1\relax
    \vspace{1\baselineskip plus 1\baselineskip minus 0.5\baselineskip}%
  }%
  \nobreak}


%% \closing the letter
%%----------------------------------------------------------------------

\def\closing{% `*'  =>  no manual signature (as for some faxes)
  \@ifstar{\closing@[0pt]}{\closing@}}

\newcommand{\closing@}[2][6\medskipamount]{%
  \par\nobreak \vskip\parskip \stopbreaks
  \noindent\hfill
  \vtop{%
    \hsize=0.7\WidthEnvelopeWindow % FIXME: what is the right size?
    \raggedright  \parindent=0pt
    \normalsize \normalbaselines
    \ignorespaces #2
    \vskip#1\relax % vertical space before signature
    \ifx \@empty \fromsig \fromname \else \fromsig  \fi
    \vskip2\medskipamount
    }%
  }



\endinput
