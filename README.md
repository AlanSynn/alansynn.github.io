# Academic Homepage Using Typst

A fairly modern and minimal academic homepage built with **Typst** and **Astro**, designed for researchers and academics to showcase their work, publications, and achievements. [[LiveDemo](https://ahxt.github.io/academic-homepage-typst/)]

- [x] typst Integration
- [x] math equations (typst) to MathML

<div align="center">
<img src="public/img.png" width="80%">
</div>

### How to

   ```bash
   git clone <repository-url>
   cd academic-homepage-typst
   npm install
   npm run dev
   ```
   
   Your site will be available at `http://localhost:4321`






### Add Content

Content is written in **Typst** files located in the `content/` directory:

- `content/about.typ` - Personal introduction and links
- `content/cv.typ` - Academic CV with education, experience, publications
- `content/news.typ` - Latest news and announcements  
- `content/blog/*.typ` - Blog posts collection



### Dependencies
- **[astro-typst](https://github.com/OverflowCat/astro-typst)**
- **[typst.ts](https://github.com/Myriad-Dreamin/typst.ts)**
- **[mathyml](https://codeberg.org/akida/mathyml)**: I copied the files from the `mathyml` package and put it in the `src/3rd_party/mathyml/` directory.
       


---

This project is open source and available under the [MIT License](LICENSE).


