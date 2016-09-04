<div class="container top-bar-single">
  <ol class="breadcrumb">
    <li><a href="/">main</a></li>
    <li class="active">blog</li>
  </ol>
</div>
<div class="container container-sm">
  <?php foreach($data as $row):?>
    <article class="row" itemtype="http://schema.org/BlogPosting" itemscope="itemscope" role="article">
      <div class="col col-sm-9 col-sm-offset-3">
        <h2 class="article-title" itemprop="headline"><?php echo $row['title'];?></h2>
      </div>
      <div class="col col-sm-3 article-meta">
        <aside role="contentinfo">
          <time datetime="<?php echo $row['changedate'];?>" itemprop="datePublished">
            <?php echo $row['changedate'];?>
            <div class="ascent-line hidden-xs"></div>
          </time>
          <div class="author media" itemprop="author">
            <div class="media-left media-middle">
              <img width="40" height="40" class="media-object img-circle" src="/images/islands-retina-50.jpg">
            </div>
            <div class="media-body media-middle">
              <h4 class="media-heading">
                <span class="first-name"><?php echo $row['employeeid'];?></span>
                <span class="last-name"><?php echo $row['employeeid'];?></span>
              </h4>
            </div>
          </div>
        </aside>
      </div>
      <div class="col col-sm-9">
        <figure>
          <img class="article-image" itemprop="image" src="/images/underconstruction.jpg">
        </figure>
        <p class="article-summary" itemprop="articleBody"><?php echo $row['body'];?></p>
      </div>
    </article>
  <?php endforeach;?>
</div>