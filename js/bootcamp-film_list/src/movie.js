import React from "react";

function MovieGrid(movie) {
    return <div className="grid" key={movie.id}>
        <p className="id">{movie.id}.</p>
        <button
            className="title"
            onClick={() => window.open(`https://www.imdb.com/find?q=${movie.title}&ref_=nv_sr_sm`)}>
            {movie.title}
        </button>
        <p className="description">{movie.description}</p>
    </div>
}

export default MovieGrid;