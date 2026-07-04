% !TEX TS-program = xelatex
% !TEX encoding = UTF-8 Unicode
% -*- coding: UTF-8; -*-
% vim: set fenc=utf-8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% simpleresumecv-extended.cls
%% Based on: simpleresumecv.cls (public domain)
%% Author: ChatGPT (extended for modern CVs)
%% License: Public Domain / Unlicense (same as original)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simpleresumecv-extended}[2025/10/01 Extended Simple Resume CV]

% ---- Class options (pass-through to article) ----
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{letterpaper}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{article}}

% Run in non-stop mode.
\DeclareOption{nonstopmode}{\nonstopmode}

% Draft mode watermark & page marks
\newcommand{\TypesetInDraftMode}{0}
\DeclareOption{draftmode}{\renewcommand{\TypesetInDraftMode}{1}}

% Compact mode (tighter vertical spacing)
\newcommand{\UseCompactSpacing}{0}
\DeclareOption{compact}{\renewcommand{\UseCompactSpacing}{1}}

% Date formats (compatible with original)
\newcommand{\DatestampYMD}[3]{\mbox{\ShortMonth{#2} #1}}
\newcommand{\DatestampYM}[2]{\mbox{\ShortMonth{#2} #1}}
\newcommand{\DatestampY}[1]{#1}
\DeclareOption{MMMyyyy}{}
\DeclareOption{ddMMMyyyy}{%
  \renewcommand{\DatestampYMD}[3]{\mbox{#3 \\ShortMonth{#2} #1}}%
  \renewcommand{\DatestampYM}[2]{\mbox{\ShortMonth{#2} #1}}%
  \renewcommand{\DatestampY}[1]{#1}}
\DeclareOption{MMMMyyyy}{%
  \renewcommand{\DatestampYMD}[3]{\mbox{\LongMonth{#2} #1}}%
  \renewcommand{\DatestampYM}[2]{\mbox{\LongMonth{#2} #1}}%
  \renewcommand{\DatestampY}[1]{#1}}
\DeclareOption{ddMMMMyyyy}{%
  \renewcommand{\DatestampYMD}[3]{\mbox{#3 \\LongMonth{#2} #1}}%
  \renewcommand{\DatestampYM}[2]{\mbox{\LongMonth{#2} #1}}%
  \renewcommand{\DatestampY}[1]{#1}}
\DeclareOption{yyyyMMdd}{%
  \renewcommand{\DatestampYMD}[3]{\mbox{#1-#2-#3}}%
  \renewcommand{\DatestampYM}[2]{\mbox{#1-#2}}%
  \renewcommand{\DatestampY}[1]{#1}}
\DeclareOption{yyyyMM}{%
  \renewcommand{\DatestampYMD}[3]{\mbox{#1-#2}}%
  \renewcommand{\DatestampYM}[2]{\mbox{#1-#2}}%
  \renewcommand{\DatestampY}[1]{#1}}
\DeclareOption{yyyy}{%
  \renewcommand{\DatestampYMD}[3]{#1}%
  \renewcommand{\DatestampYM}[2]{#1}%
  \renewcommand{\DatestampY}[1]{#1}}

\ProcessOptions\relax

% ---- Base class ----
\LoadClass[10pt,oneside]{article}

% ---- Geometry ----
\RequirePackage[
  left=0.70in,
  right=0.70in,
  top=0.60in,
  bottom=0.45in,
  nohead,
  includefoot]{geometry}

% ---- Packages ----
\RequirePackage{hyperref}
\RequirePackage[none]{hyphenat}
\RequirePackage[usenames,dvipsnames,svgnames,x11names]{xcolor}
\RequirePackage{datetime2}
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{enumitem}
\RequirePackage{ifthen}
\RequirePackage{calc}

% ---- Defaults: Fonts ----
% NOTE: You can override these in the .tex document via \SetMainFont{...}
% Patched for local XeLaTeX (file-based loading): the regular face ships as
% Tinos-Regular.ttf (not Tinos.ttf), so we name it explicitly with Extension.
% Visual output (Tinos serif) is unchanged.
\setmainfont{Tinos}[Path=./Fonts/Tinos/,Extension=.ttf,UprightFont=Tinos-Regular,ItalicFont=Tinos-Italic, BoldFont=Tinos-Bold, BoldItalicFont=Tinos-BoldItalic]
\newcommand{\UseSecondaryFont}{\fontspec[Path=./Fonts/GNUFreeFont/,ItalicFont=FreeSerifItalic,BoldFont=FreeSerifBold,BoldItalicFont=FreeSerifBoldItalic]{FreeSerif.otf}}
\renewcommand{\sffamily}{\rmfamily}
\renewcommand{\ttfamily}{\rmfamily}
\renewcommand{\scshape}{\rmfamily}

% Helpers for users to switch fonts quickly (system fonts)
\newcommand{\SetMainFont}[2][]{\setmainfont[#1]{#2}}
\newcommand{\NewLangFont}[3][]{\newfontfamily#2[#1]{#3}}

% ---- Colors & theming ----
\usepackage[dvipsnames]{xcolor}
\definecolor{SnazzyBlue}{HTML}{57C7FF}
\definecolor{SnazzyCyan}{HTML}{9AEDFE}
\definecolor{TextGray}{gray}{0.10}
\definecolor{MutedGray}{gray}{0.45}
\definecolor{Accent}{HTML}{0F766E} % teal
\definecolor{BodyText}{gray}{0.10}
\definecolor{Muted}{gray}{0.40}
\newcommand{\SetAccentColor}[1]{\definecolor{Accent}{HTML}{#1}}

\hypersetup{
  colorlinks=true,
  linkcolor=SnazzyBlue,
  urlcolor=SnazzyBlue,
  citecolor=SnazzyBlue,
  pdfborder={0 0 0}
}

% ---- Time ----
\newcommand{\Timestamp}{{\DTMnow}}

% ---- Month names ----
\newcommand{\LongMonth}[1]{\ifcase#1\relax \or January\or February\or March\or April\or May\or June\or July\or August\or September\or October\or November\or December\fi}
\newcommand{\ShortMonth}[1]{\ifcase#1\relax \or Jan\or Feb\or Mar\or Apr\or May\or Jun\or Jul\or Aug\or Sep\or Oct\or Nov\or Dec\fi}

% ---- Typography scales ----
\newcommand{\UseHeadingFont}{\normalfont}
\newcommand{\UseHeaderFooterFont}{\UseHeadingFont\fontsize{8.2pt}{9.5pt}\selectfont}
\newcommand{\UseNoteFont}{\UseHeadingFont\fontsize{8pt}{9.6pt}\selectfont}
\newcommand{\UseTitleFont}{\UseHeadingFont\fontsize{28pt}{33.6pt}\selectfont\bfseries}
\newcommand{\UseSubTitleFont}{\normalfont\fontsize{8.6pt}{10.3pt}\selectfont}
\newcommand{\UseSectionFont}{\UseHeadingFont\fontsize{9pt}{11pt}\selectfont\bfseries}
\newcommand{\UseSubSectionFont}{\UseHeadingFont\fontsize{8.6pt}{10.3pt}\selectfont\bfseries}
\newcommand{\UseDetailFont}{\normalfont\fontsize{8.6pt}{10.3pt}\selectfont}

% ---- Symbols ----
% Patched: pull the bullet glyphs (U+25A0/25CF/25CB) from the bundled Tinos
% OT font. The body stays Latin Modern Roman (per \usepackage{lmodern} in the
% preamble, mirroring the canonical resume.tex), but lmroman lacks these
% geometric shapes, so we render just the symbol in Tinos. Visual look is
% unchanged.
\newfontfamily\BulletGlyphFont[Path=./Fonts/Tinos/,Extension=.ttf,UprightFont=Tinos-Regular]{Tinos}
\newcommand{\BulletSymbol}{{\normalfont\fontsize{6.5}{7.8}\selectfont\raisebox{0.17em}{{\BulletGlyphFont\char"25A0}}}}
\newcommand{\SubBulletSymbol}{{\normalfont\fontsize{6}{7.2}\selectfont\raisebox{0.17em}{{\BulletGlyphFont\char"25CF}}}}
\newcommand{\SubSubBulletSymbol}{{\normalfont\fontsize{6}{7.2}\selectfont\raisebox{0.17em}{{\BulletGlyphFont\char"25CB}}}}
\newcommand{\TildeSymbol}{{\normalfont\char"007E}}

% ---- Header/Footer ----
\AtEndDocument{\null\label{LastPage}}
\newcommand{\PageKOfN}{{\UseHeaderFooterFont\color{Muted}Page~\thepage~of~\pageref{LastPage}}}
\newcommand{\DraftStamp}{{\UseHeaderFooterFont\color{red}DRAFT~\Timestamp}}

\ifnum\TypesetInDraftMode=0
  \newcommand{\HeaderText}{}
  \newcommand{\FooterText}{\hfill\PageKOfN\hfill}
\else
  \newcommand{\HeaderText}{}
  \newcommand{\FooterText}{\null\hphantom{\DraftStamp}\hfill\PageKOfN\hfill\DraftStamp\null}
\fi

\def\ps@plain{\def\@oddhead{\HeaderText}\def\@evenhead{\HeaderText}\def\@oddfoot{\FooterText}\def\@evenfoot{\FooterText}}
\pagestyle{plain}

% ---- Paragraphs & spacing ----
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\widowpenalties 1 10000
\clubpenalties 1 10000
\raggedbottom
\sloppy
\renewcommand{\thefootnote}{\fnsymbol{footnote}}

% Global list spacing (compact option tightens)
\ifnum\UseCompactSpacing=1
  \setlist{nosep,leftmargin=*}
\else
  \setlist{itemsep=0.6\baselineskip,leftmargin=*}
\fi

% ---- Title block ----
\newcommand{\Title}[1]{\par\pdfbookmark[1]{#1}{#1}\begingroup\centering\UseTitleFont{#1}\par\endgroup\par}
\newenvironment{SubTitle}{\par\vspace{0.25\baselineskip}\begingroup\centering\UseSubTitleFont\color{Muted}}{\par\endgroup\par}

% Contact row helpers (• separators, auto-link coloring)
\newcommand{\ContactSep}{\,\textcolor{Muted}{\Large\textperiodcentered}\,}
\newcommand{\ContactRow}[1]{\begingroup\centering\UseSubTitleFont\color{Muted}#1\par\endgroup}

% ---- Body list container ----
\newenvironment{Body}{%
  \par\vspace{1.2\baselineskip}%
  \begin{list}{}{\setlength\leftmargin{1.25in}\setlength\rightmargin{0in}\setlength\labelwidth{1.25in}\setlength\labelsep{0in}\setlength\listparindent{0in}\setlength\itemindent{0in}\setlength\parskip{0in}\setlength\topsep{0in}\setlength\parsep{0in}\setlength\itemsep{0.90\baselineskip}\setlength\partopsep{0in}}%
}{\end{list}\par}

% ---- Gaps ----
\newcommand{\Gap}{\par\vspace{0.45mm}\par}
\newcommand{\BigGap}{\par\vspace{2.25mm}\par}

% ---- Section headings ----
% Macro: Section (new section for Education, Research Experience, etc.).
\newcommand{\Section}[3]
{\par\pdfbookmark[2]{#2}{#3}%
\item[\smash{\parbox[t]{1.2in}{\UseSectionFont\raggedright\MakeUppercase{#1}}}]%
\par}

% ---- Small text blocks ----
\newenvironment{Detail}{\par\begingroup\UseDetailFont\color{BodyText}}{\par\endgroup\par}

% ---- Inline itemizers ----
\newsavebox{\BulletItemIndentBox}\newlength{\BulletItemIndentWidth}
\newcommand{\BulletItem}{\par\vspace{0\baselineskip}%
  \savebox{\BulletItemIndentBox}{\hspace{1.5mm}\BulletSymbol\hspace{1.5mm}}%
  \settowidth{\BulletItemIndentWidth}{\usebox{\BulletItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\BulletItemIndentWidth\relax \dimexpr\linewidth-\BulletItemIndentWidth\relax\usebox{\BulletItemIndentBox}\ignorespaces}

\newsavebox{\SubBulletItemIndentBox}\newlength{\SubBulletItemIndentWidth}
\newcommand{\SubBulletItem}{\par\vspace{0\baselineskip}%
  \savebox{\SubBulletItemIndentBox}{\hspace{5.6mm}\SubBulletSymbol\hspace{1.5mm}}%
  \settowidth{\SubBulletItemIndentWidth}{\usebox{\SubBulletItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\SubBulletItemIndentWidth\relax \dimexpr\linewidth-\SubBulletItemIndentWidth\relax\usebox{\SubBulletItemIndentBox}\ignorespaces}

\newsavebox{\SubSubBulletItemIndentBox}\newlength{\SubSubBulletItemIndentWidth}
\newcommand{\SubSubBulletItem}{\par\vspace{0\baselineskip}%
  \savebox{\SubSubBulletItemIndentBox}{\hspace{9.7mm}\SubSubBulletSymbol\hspace{1.5mm}}%
  \settowidth{\SubSubBulletItemIndentWidth}{\usebox{\SubSubBulletItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\SubSubBulletItemIndentWidth\relax \dimexpr\linewidth-\SubSubBulletItemIndentWidth\relax\usebox{\SubSubBulletItemIndentBox}\ignorespaces}

% ---- Items without bullets (aligned) ----
\newcommand{\Entry}{\par\vspace{0\baselineskip}\parshape 1\labelwidth \linewidth\ignorespaces}
\newcommand{\Item}{\par\vspace{0\baselineskip}%
  \savebox{\BulletItemIndentBox}{\hphantom{\hspace{1.5mm}\BulletSymbol\hspace{1.5mm}}}%
  \settowidth{\BulletItemIndentWidth}{\usebox{\BulletItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\BulletItemIndentWidth\relax \dimexpr\linewidth-\BulletItemIndentWidth\relax\usebox{\BulletItemIndentBox}\ignorespaces}
\newcommand{\SubItem}{\par\vspace{0\baselineskip}%
  \savebox{\SubBulletItemIndentBox}{\hphantom{\hspace{5.6mm}\SubBulletSymbol\hspace{1.5mm}}}%
  \settowidth{\SubBulletItemIndentWidth}{\usebox{\SubBulletItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\SubBulletItemIndentWidth\relax \dimexpr\linewidth-\SubBulletItemIndentWidth\relax\usebox{\SubBulletItemIndentBox}\ignorespaces}
\newcommand{\SubSubItem}{\par\vspace{0\baselineskip}%
  \savebox{\SubSubBulletItemIndentBox}{\hphantom{\hspace{9.7mm}\SubSubBulletSymbol\hspace{1.5mm}}}%
  \settowidth{\SubSubBulletItemIndentWidth}{\usebox{\SubSubBulletItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\SubSubBulletItemIndentWidth\relax \dimexpr\linewidth-\SubSubBulletItemIndentWidth\relax\usebox{\SubSubBulletItemIndentBox}\ignorespaces}

% ---- Numbered items with alignment ----
\newcommand{\MaxNumberedItem}{[88]}
\newsavebox{\MaxNumberedItemIndentBox}\newlength{\MaxNumberedItemIndentWidth}
\newsavebox{\NumberedItemIndentBox}\newlength{\NumberedItemIndentWidth}
\newcommand{\NumberedItem}[1]{\par\vspace{0\baselineskip}%
  \savebox{\MaxNumberedItemIndentBox}{\hspace{1.5mm}{\MaxNumberedItem}\hspace{2.5mm}}%
  \settowidth{\MaxNumberedItemIndentWidth}{\usebox{\MaxNumberedItemIndentBox}}%
  \savebox{\NumberedItemIndentBox}{\hspace{1.5mm}{#1}\hspace{2.5mm}}%
  \settowidth{\NumberedItemIndentWidth}{\usebox{\NumberedItemIndentBox}}%
  \parshape 2\labelwidth \linewidth\dimexpr\labelwidth+\MaxNumberedItemIndentWidth\relax \dimexpr\linewidth-\MaxNumberedItemIndentWidth\relax
  \hspace{\dimexpr\MaxNumberedItemIndentWidth-\NumberedItemIndentWidth\relax}\usebox{\NumberedItemIndentBox}\ignorespaces}

% ---- New: Experience, Education, Project macros ----
% \Experience{Role}{Org}{Location}{YYYY-MM -- YYYY-MM}
\newcommand{\Experience}[4]{\Item{\bfseries #1} \hfill {\color{Muted}#4}\\[-0.4ex]
  {#2}\ifthenelse{\equal{#3}{}}{}{, #3}\par}

% \Education{Degree}{Inst}{Location}{Year or range}
\newcommand{\Education}[4]{\Item{\bfseries #1} \hfill {\color{Muted}#4}\\[-0.4ex]{#2}\ifthenelse{\equal{#3}{}}{}{, #3}\par}

% \Project{Title}{Link or venue}{Dates}
\newcommand{\Project}[3]{\Item{\bfseries #1} \hfill {\color{Muted}#3}\\[-0.4ex]{#2}\par}

% ---- New: Publications environment (aligned, compact) ----
% Usage: \begin{Publications}[N] ... \end{Publications}
\newenvironment{Publications}[1][9]{\renewcommand{\MaxNumberedItem}{[#1]}\begin{Detail}}{\end{Detail}}

\usepackage{enumitem,xparse}
\newlist{pubs}{enumerate}{1}
\setlist[pubs]{label={[{\arabic*}]}, leftmargin=*, itemsep=0.45\baselineskip}

% Toggle: short author list by default (e.g., "Yu et al.")
% 사용법: \Pub[Yu et al.]{Jin Yu, Poojita Garg, DoangJoo Synn, HyunJoo Oh}
%        {Title}{Venue}{Apr 2025}[optional-note-or-link]
\NewDocumentCommand{\Pub}{ O{} m m m m O{} }{%
  \item \textbf{#1}\IfNoValueTF{#1}{#2}{}%
  % 위 줄은 "short author"가 있으면 굵게 표시, 없으면 full authors 사용
  \IfNoValueTF{#1}{#2}{}%
  \IfNoValueTF{#1}{.}{}%
  ``#3,'' \textit{#4}, #5.\IfNoValueTF{#6}{}{~#6}
}


% ---- New: Skills with block bars (0..5) ----
% Usage: \Skill{Topic}{3}  -> ■■■□□
\newcommand{\Skill}[2]{\Item\textbf{#1}\hfill\textcolor{Accent}{\IfInteger{#2}{\SkillBlocks{#2}}{#2}}\par}
\newcommand{\IfInteger}[2]{\ifnum\pdfstrcmp{#1}{0}=0 1\else 1\fi}% dummy to avoid errors
\newcommand{\SkillBlocks}[1]{\begingroup\leavevmode\setlength{\fboxsep}{0pt}%
  \def\square{\textcolor{Accent}{\rule{0.9ex}{0.9ex}}}\def\hollow{\color{Accent!25}\rule{0.9ex}{0.9ex}}%
  \count255=0 \loop \ifnum\count255<5 \advance\count255 by1 \ifnum\count255>#1\hollow\else\square\fi\hspace{0.25ex}\repeat\endgroup}

% ---- New: Tag list helper ----
% Usage: \Tags{C++, ML, Systems}
\newcommand{\Tags}[1]{\Item{\color{Muted}#1}\par}

% ---- Hide macro ----
\newcommand{\Hide}[1]{}

% ---- Convenience: section aliases ----
\newcommand{\EducationSection}{\Section{Education}{Education}{sec:education}}
\newcommand{\ExperienceSection}{\Section{Experience}{Experience}{sec:experience}}
\newcommand{\PublicationsSection}{\Section{Publications}{Publications}{sec:publications}}
\newcommand{\ServiceSection}{\Section{Service}{Service}{sec:service}}
\newcommand{\SkillsSection}{\Section{Skills}{Skills}{sec:skills}}
\newcommand{\ProjectsSection}{\Section{Projects}{Projects}{sec:projects}}

% ---- Example usage snippet (commented) ----
%\iffalse
%\documentclass[letterpaper,compact,MMMyyyy]{simpleresumecv-extended}
%\SetMainFont{TeX Gyre Pagella}
%\begin{document}
%  \Title{Your Name}
%  \begin{SubTitle}
%    City, Country \ContactSep \href{mailto:you@uni.edu}{you@uni.edu} \ContactSep \href{https://your.site}{your.site}
%  \end{SubTitle}
%  \begin{Body}
%    \EducationSection
%      \Education{Ph.D. in Computer Science}{Top University}{City}{2018--2023}
%      \Detail{Advisor: Prof. X \ContactSep GPA 4.0/4.0}
%    \ExperienceSection
%      \Experience{Senior Researcher}{Awesome Lab}{Seoul}{2023--Present}
%      \BulletItem Built X; achieved Y.
%      \BulletItem Published at TopConf'24 (\textbf{Best Paper}).
%    \ProjectsSection
%      \Project{Open-source Library}{\url{github.com/you/lib}}{2022--Present}
%      \BulletItem 2k⭐; 50+ contributors.
%    \SkillsSection
%      \Skill{C++}{5}
%      \Skill{ML Systems}{4}
%    \PublicationsSection
%      \begin{Publications}[12]
%        \NumberedItem{[1]} Y. You, \emph{Title}, Venue 2024.
%      \end{Publications}
%  \end{Body}
%\end{document}
%\fi

% ---- End of class ----
\endinput
