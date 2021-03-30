const starRating = () => {
  const starRatingDivs = document.querySelectorAll('.star-rating');
  const fullStar = "<i class=\"fas fa-star\"></i>";
  const emptyStar = "<i class=\"far fa-star\"></i>";
  const halfStar = "<i class=\"fas fa-star-half-alt\"></i>"
  starRatingDivs.forEach(starRatingDiv => {
    const ratingValue = parseInt(starRatingDiv.dataset.rating, 10);
    starRatingDiv.innerHTML = `
      ${fullStar.repeat(ratingValue)}${emptyStar.repeat(5 - ratingValue)}
    `;
  })
}

export { starRating }