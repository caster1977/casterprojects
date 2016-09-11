<div class="container top-bar-single">
  <ol class="breadcrumb">
    <li><a href="/">main</a></li>
    <li class="active">blog</li>
  </ol>
</div>
<div class="blog container container-sm">
  <?php foreach($data['blog'] as $row):?>
    <article class="row">
      <div class="col col-sm-9 col-sm-offset-3">
        <h2 class="article-title"><?php echo $row['title'];?></h2>
      </div>
      <div class="col col-sm-3 article-meta">
        <aside>
          <time datetime="<?php echo $row['changedate'];?>">
            <?php echo $row['changedate'];?>
            <div class="ascent-line hidden-xs"></div>
          </time>
          <div class="article-author">
            <div class="article-author-img">
              <img class="img-circle" src="<?php echo $data['employees'][$row['employeeid']]['avatar'];?>">
            </div>
            <div class="article-author-name">
              <h4>
                <span class="first-name"><?php echo $data['employees'][$row['employeeid']]['firstname'];?></span>
                <span class="last-name"><?php echo $data['employees'][$row['employeeid']]['lastname'];?></span>
              </h4>
            </div>
          </div>
        </aside>
      </div>
      <div class="col col-sm-9">        
        <img class="article-image" src="<?php echo $row['image'];?>">
        <p class="article-body"><?php echo $row['body'];?></p>
      </div>
    </article>
  <?php endforeach;?>
</div>